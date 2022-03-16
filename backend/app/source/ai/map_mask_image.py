

import pandas as pd
import os
import stat
import shutil
import cv2
import numpy as np
from PIL import Image
import matplotlib.pyplot as plt
import glob
import os
import cv2
import tensorflow as tf
from skimage import morphology
from tensorflow.keras.layers import Input, Conv2D, MaxPool2D, UpSampling2D, Concatenate, Add, Flatten
img_w = 100 # resized weidth
img_h = 100 # resized height
k_size = 3 # kernel size 3x3
# get all files using glob
submission = []
test_files = [f for f in glob.glob('C:/Users/Ghera/source/repos/test_flask_python/app/source/files/gif_images/' + "*.jpeg", recursive=True)]
pretrained_model_path = 'C:/Users/Ghera/Desktop/models_segm/ResUNetBladder_v13.h5' # path of pretrained model



load_pretrained_model = True # load a pre-trained model
# Create your dictionary class
class my_dictionary(dict):
  
    # __init__ function
    def __init__(self):
        self = dict()
          
    # Function to add key:value
    def add(self, key, value):
        self[key] = value

def rle_to_mask(rle_string,height,width):
    '''
    convert RLE(run length encoding) string to numpy array

    Parameters: 
    rleString (str): Description of arg1 
    height (int): height of the mask
    width (int): width of the mask 

    Returns: 
    numpy.array: numpy array of the mask
    '''
    rows, cols = height, width
    if rle_string == -1:
        return np.zeros((height, width))
    else:
        rleNumbers = [int(numstring) for numstring in rle_string.split(' ')]
        rlePairs = np.array(rleNumbers).reshape(-1,2)
        img = np.zeros(rows*cols,dtype=np.uint8)
        for index,length in rlePairs:
            index -= 1
            img[index:index+length] = 255
        img = img.reshape(cols,rows)
        img = img.T
        return img

def bn_act(x, act=True):
    'batch normalization layer with an optinal activation layer'
    x = tf.keras.layers.BatchNormalization()(x)
    if act == True:
        x = tf.keras.layers.Activation('relu')(x)
    return x


def conv_block(x, filters, kernel_size=3, padding='same', strides=1):
    'convolutional layer which always uses the batch normalization layer'
    conv = bn_act(x)
    conv = Conv2D(filters, kernel_size, padding=padding, strides=strides)(conv)
    return conv
def stem(x, filters, kernel_size=3, padding='same', strides=1):
    conv = Conv2D(filters, kernel_size, padding=padding, strides=strides)(x)
    conv = conv_block(conv, filters, kernel_size, padding, strides)
    shortcut = Conv2D(filters, kernel_size=1, padding=padding, strides=strides)(x)
    shortcut = bn_act(shortcut, act=False)
    output = Add()([conv, shortcut])
    return output


def residual_block(x, filters, kernel_size=3, padding='same', strides=1):
    res = conv_block(x, filters, k_size, padding, strides)
    res = conv_block(res, filters, k_size, padding, 1)
    shortcut = Conv2D(filters, kernel_size, padding=padding, strides=strides)(x)
    shortcut = bn_act(shortcut, act=False)
    output = Add()([shortcut, res])
    return output

def upsample_concat_block(x, xskip):
    u = UpSampling2D((2,2))(x)
    c = Concatenate()([u, xskip])
    return c



def ResUNet(img_h, img_w):
    f = [4, 8, 16, 32, 64]
    inputs = Input((64, 64, 1))
    
    ## Encoder
    e0 = inputs
    e1 = stem(e0, f[0])
    e2 = residual_block(e1, f[1], strides=2)
    e3 = residual_block(e2, f[2], strides=2)
    e4 = residual_block(e3, f[3], strides=2)
    e5 = residual_block(e4, f[4], strides=2)
    
    ## Bridge
    b0 = conv_block(e5, f[4], strides=1)
    b1 = conv_block(b0, f[4], strides=1)
    
    ## Decoder
    u1 = upsample_concat_block(b1, e4)
    d1 = residual_block(u1, f[4])
    
    u2 = upsample_concat_block(d1, e3)
    d2 = residual_block(u2, f[3])
    
    u3 = upsample_concat_block(d2, e2)
    d3 = residual_block(u3, f[2])
    
    u4 = upsample_concat_block(d3, e1)
    d4 = residual_block(u4, f[1])
    
    outputs = tf.keras.layers.Conv2D(2, (1, 1), padding="same", activation="sigmoid")(d4)
    model = tf.keras.models.Model(inputs, outputs)
    return model

def tversky(y_true, y_pred, smooth=1e-6):
    y_true_pos = tf.keras.layers.Flatten()(y_true)
    y_pred_pos = tf.keras.layers.Flatten()(y_pred)
    true_pos = tf.reduce_sum(y_true_pos * y_pred_pos)
    false_neg = tf.reduce_sum(y_true_pos * (1-y_pred_pos))
    false_pos = tf.reduce_sum((1-y_true_pos)*y_pred_pos)
    alpha = 0.7
    return (true_pos + smooth)/(true_pos + alpha*false_neg + (1-alpha)*false_pos + smooth)

def tversky_loss(y_true, y_pred):
    return 1 - tversky(y_true,y_pred)


def focal_tversky_loss(y_true,y_pred):
    #y_true = y_true.astype('float32')
    y_true = tf.cast(y_true, tf.float32)
    y_true = tf.cast(y_true, "float32")
    tf.cast(y_true, "float32")
    print(y_true)
    print(y_pred)
    pt_1 = tversky(y_true, y_pred)
    gamma = 0.75
    return tf.keras.backend.pow((1-pt_1), gamma)

def mask_to_rle(mask):
    '''
    Convert a mask into RLE
    
    Parameters: 
    mask (numpy.array): binary mask of numpy array where 1 - mask, 0 - background

    Returns: 
    sring: run length encoding 
    '''
    pixels= mask.T.flatten()
    pixels = np.concatenate([[0], pixels, [0]])
    runs = np.where(pixels[1:] != pixels[:-1])[0] + 1
    runs[1::2] -= runs[::2]
    return ' '.join(str(x) for x in runs)


def remove_small_regions(img, size):
    """Morphologically removes small (less than size) connected regions of 0s or 1s."""
    img = morphology.remove_small_objects(img, size)
    img = morphology.remove_small_holes(img, size)
    return img


# a function to apply all the processing steps necessery to each of the individual masks
def process_pred_mask(pred_mask):
    
    pred_mask = cv2.resize(pred_mask.astype('float32'),(100, 100))
    pred_mask = (pred_mask > .5).astype(int)
    pred_mask = remove_small_regions(pred_mask, 0.02 * np.prod(512)) * 255
    pred_mask = mask_to_rle(pred_mask)
    
    return pred_mask



# return tensor in the right shape for prediction 
def get_test_tensor(img_dir, img_h, img_w, channels=1):

    X = np.empty((1, img_h, img_w, channels))
    # Store sample
    image = cv2.imread(img_dir, 0)
    image_resized = cv2.resize(image, (img_w, img_h))
    image_resized = np.array(image_resized, dtype=np.float64)
    # normalize image
    image_resized -= image_resized.mean()
    image_resized /= image_resized.std()
    
    X[0,] = np.expand_dims(image_resized, axis=2)

    return X

def genereate_segmented_images(path_images,parameters):
    
    fileVariable = open('C:/Users/Ghera/source/repos/test_flask_python/app/source/submission.csv', 'r+')
    fileVariable.truncate(0)
    fileVariable.close()

    model = ResUNet(img_h=img_h, img_w=img_w)
    adam = tf.keras.optimizers.Adam(lr = 0.05, epsilon = 0.1)
    model.compile(optimizer=adam, loss=focal_tversky_loss, metrics=[tversky])
    model.summary()

    font = cv2.FONT_HERSHEY_PLAIN
    if load_pretrained_model:
        try:
            model.load_weights(pretrained_model_path)
            print('pre-trained model loaded!')
        except OSError:
            print('You need to run the model and load the trained model')



    # loop over all the test images
    i=0
    for f in test_files:
        i+=1
        # get test tensor, output is in shape: (1, 256, 512, 3)
        test = get_test_tensor(f, 64, 64) 
        # get prediction, output is in shape: (1, 256, 512, 4)
        pred_masks = model.predict(test) 
        # get a list of masks with shape: 256, 512
        pred_masks = [pred_masks[0][...,i] for i in range(0,2)]
        # if(pred_masks[0][0] == ''):
        #     pred_masks[0][0] = '0 0'
        # if(pred_masks[0][1] == ''):
        #     pred_masks[0][1] = '0 0'
        # apply all the processing steps to each of the mask
        # print("[0][0]",pred_masks[0][0])
        # print("[0][1]",pred_masks[0][1])
        pred_masks = [process_pred_mask(pred_mask) for pred_mask in pred_masks]
        # get our image id
        id = f.split('/')[-1]
        # create ImageId_ClassId and get the EncodedPixels for the class ID, and append to our submissions list
        for k, pred_mask in enumerate(pred_masks):
            if pred_mask == '':
                pred_mask='0 0'
            [submission.append((id+'_%s' % (k+1), pred_mask))]
        #if i == 5:
        #    break
    [submission.append(("gif_images\888.jpeg"+'_%s' % "1000 100 10 1", 1))]
    # convert to a csv
    submission_df = pd.DataFrame(submission, columns=['ImageId_ClassId', 'EncodedPixels'])
    # check out some predictions and see if RLE looks ok
    submission_df[ submission_df['EncodedPixels'] != ''].head()



    # take a look at our submission 
    submission_df.head()



    # write it out
    submission_df.to_csv('./submission.csv', index=False)



    segm_df = pd.read_csv(os.path.join("C:/Users/Ghera/source/repos/test_flask_python/app/source/", 'submission.csv')).fillna(-1)
    segm_images =[]
    # image id and class id are two seperate entities and it makes it easier to split them up in two columns
    segm_df['ImageId'] = segm_df['ImageId_ClassId'].apply(lambda x: x.split('_')[1])
    segm_df['ClassId'] = segm_df['ImageId_ClassId'].apply(lambda x: x.split('_')[2])
    # lets create a dict with class id and encoded pixels and group all the defaults per image
    segm_df['EncodedPixels'] = segm_df['EncodedPixels']

    dict_obj = my_dictionary()
    for el_path in path_images:
        id_img = int((el_path.split('.')[0]).split('/')[-1])
        for el_subm in range(0,len(segm_df['ImageId'])-1):
            
            id_subm = int(segm_df['ImageId'][el_subm].split("\\")[-1].split('.')[0])
            if (id_img == id_subm) and (int(segm_df['ClassId'][el_subm]) == 1):
                dict_obj.add(str(id_subm)+"_"+str(1), segm_df['EncodedPixels'][el_subm])
            if (id_img == id_subm) and (int(segm_df['ClassId'][el_subm]) == 2):
                dict_obj.add(str(id_subm)+"_"+str(2), segm_df['EncodedPixels'][el_subm])
    #print(dict_obj)
    files ="C:/Users/Ghera/source/repos/test_flask_python/app/source/files/segmented_images"
    os.chmod(files, stat.S_IRUSR | stat.S_IWUSR | stat.S_IXUSR)
    shutil.rmtree(files, ignore_errors=False)
    list_imgs=[]
    print("File deleted")
    directory = "segmented_images"
  
    parent_dir = "C:/Users/Ghera/source/repos/test_flask_python/app/source/files/"
  
    path = os.path.join(parent_dir, directory)
    os.mkdir(path)
    colors = np.random.uniform(0,255,size=(2,3))
    for the_key, the_value in dict_obj.items():
            print(the_key, 'corresponds to', the_value)
            key_class = int(the_key.split('_')[1])
            if(key_class == 1):
                key =  int(the_key.split('_')[0])
                pth_img1 = "C:/Users/Ghera/source/repos/test_flask_python/app/source/files/images/pacient1/img" + str(key) + ".jpeg"
                img1 = cv2.imread(pth_img1)
                img3 = rle_to_mask(the_value,100,100)
                
                heightimg1 = img1.shape[0]
                widthimg1 = img1.shape[1]

                img3 = cv2.resize(img3, (widthimg1,heightimg1), interpolation = cv2.INTER_AREA)
                # plt.imshow(img3)
                # plt.show()

                #find the contours from the thresholded image
                _, binary = cv2.threshold(img3, 225, 255, cv2.THRESH_BINARY_INV)
                contours, hierarchy = cv2.findContours(binary, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
                # #        draw all contours
                img1 = cv2.drawContours(img1, contours, -1, (255, 255, 0), 2)
                # find the contours from the thresholded image
                #contours, hierarchy = cv2.findContours(binary, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
                # draw all contours
                #img3 = cv2.drawContours(img3, contours, -1, (0, 255, 0), 2)
            


                mask2_val = str(key) + "_" + str(2)
                mask2 = dict_obj[mask2_val]
                img4 = rle_to_mask(mask2,100,100)
                img4 = cv2.resize(img4, (widthimg1,heightimg1), interpolation = cv2.INTER_AREA)
            
                # find the contours from the thresholded image
                _, binary = cv2.threshold(img4, 225, 255, cv2.THRESH_BINARY_INV)
                contours, hierarchy = cv2.findContours(binary, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
                #        draw all contours
                img1 = cv2.drawContours(img1, contours, -1, (0, 255, 0), 2)

                            
                redImg = np.zeros(img1.shape, img1.dtype)
                redImg[:,:] = (0, 0, 255)
                redMask = cv2.bitwise_and(redImg, redImg, mask=img3)
                cv2.addWeighted(redMask, 1, img1, 1, 0, img1)


                blueImg = np.zeros(img1.shape, img1.dtype)
                blueImg[:,:] = (255, 0, 0)
                redMask = cv2.bitwise_and(blueImg, blueImg, mask=img4)
                cv2.addWeighted(redMask, 1, img1, 1, 0, img1)


                #roi localization add
                #cv2.rectangle(img1,(z[0],z[1]),(z[0]+z[2],z[1]+z[3]),color,2)
                
                color = colors[0]
                cv2.rectangle(img1,(parameters[0],parameters[1]),(parameters[0]+parameters[2]+40,parameters[1]+parameters[3]+40),color,2)
                #cv2.rectangle(my_img,(avg_x,              avg_y),(avg_x        +     avg_w+20,        avg_y+     avg_h+20),color,2)
                cv2.putText(img1,"bladder " + str(parameters[4]),(parameters[0],parameters[1]),font,2,(255,255,255),2)
                
                cv2.imwrite(os.path.join("C:/Users/Ghera/source/repos/test_flask_python/app/source/files/segmented_images/" , str(key) +'.jpeg'), img1) 
                pth_segm = "C:/Users/Ghera/source/repos/test_flask_python/app/source/files/segmented_images/" + str(key) +'.jpeg'
                segm_images.append(pth_segm)
    return segm_images  
