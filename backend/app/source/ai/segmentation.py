# import glob
# import numpy as np
# import os
# import cv2
# import tensorflow as tf
# import pandas as pd
# from skimage import morphology
# from tensorflow.keras.layers import Input, Conv2D, MaxPool2D, UpSampling2D, Concatenate, Add, Flatten
# img_w = 100 # resized weidth
# img_h = 100 # resized height
# k_size = 3 # kernel size 3x3
# # get all files using glob
# submission = []
# test_files = [f for f in glob.glob('C:/Users/Ghera/source/repos/test_flask_python/app/source/files/gif_images/' + "*.jpeg", recursive=True)]
# pretrained_model_path = 'C:/Users/Ghera/Desktop/models_segm/ResUNetBladderY.h5' # path of pretrained model



# load_pretrained_model = True # load a pre-trained model
# def bn_act(x, act=True):
#     'batch normalization layer with an optinal activation layer'
#     x = tf.keras.layers.BatchNormalization()(x)
#     if act == True:
#         x = tf.keras.layers.Activation('relu')(x)
#     return x


# def conv_block(x, filters, kernel_size=3, padding='same', strides=1):
#     'convolutional layer which always uses the batch normalization layer'
#     conv = bn_act(x)
#     conv = Conv2D(filters, kernel_size, padding=padding, strides=strides)(conv)
#     return conv
# def stem(x, filters, kernel_size=3, padding='same', strides=1):
#     conv = Conv2D(filters, kernel_size, padding=padding, strides=strides)(x)
#     conv = conv_block(conv, filters, kernel_size, padding, strides)
#     shortcut = Conv2D(filters, kernel_size=1, padding=padding, strides=strides)(x)
#     shortcut = bn_act(shortcut, act=False)
#     output = Add()([conv, shortcut])
#     return output


# def residual_block(x, filters, kernel_size=3, padding='same', strides=1):
#     res = conv_block(x, filters, k_size, padding, strides)
#     res = conv_block(res, filters, k_size, padding, 1)
#     shortcut = Conv2D(filters, kernel_size, padding=padding, strides=strides)(x)
#     shortcut = bn_act(shortcut, act=False)
#     output = Add()([shortcut, res])
#     return output

# def upsample_concat_block(x, xskip):
#     u = UpSampling2D((2,2))(x)
#     c = Concatenate()([u, xskip])
#     return c



# def ResUNet(img_h, img_w):
#     f = [4, 8, 16, 32, 64]
#     inputs = Input((64, 64, 1))
    
#     ## Encoder
#     e0 = inputs
#     e1 = stem(e0, f[0])
#     e2 = residual_block(e1, f[1], strides=2)
#     e3 = residual_block(e2, f[2], strides=2)
#     e4 = residual_block(e3, f[3], strides=2)
#     e5 = residual_block(e4, f[4], strides=2)
    
#     ## Bridge
#     b0 = conv_block(e5, f[4], strides=1)
#     b1 = conv_block(b0, f[4], strides=1)
    
#     ## Decoder
#     u1 = upsample_concat_block(b1, e4)
#     d1 = residual_block(u1, f[4])
    
#     u2 = upsample_concat_block(d1, e3)
#     d2 = residual_block(u2, f[3])
    
#     u3 = upsample_concat_block(d2, e2)
#     d3 = residual_block(u3, f[2])
    
#     u4 = upsample_concat_block(d3, e1)
#     d4 = residual_block(u4, f[1])
    
#     outputs = tf.keras.layers.Conv2D(4, (1, 1), padding="same", activation="sigmoid")(d4)
#     model = tf.keras.models.Model(inputs, outputs)
#     return model

# def tversky(y_true, y_pred, smooth=1e-6):
#     y_true_pos = tf.keras.layers.Flatten()(y_true)
#     y_pred_pos = tf.keras.layers.Flatten()(y_pred)
#     true_pos = tf.reduce_sum(y_true_pos * y_pred_pos)
#     false_neg = tf.reduce_sum(y_true_pos * (1-y_pred_pos))
#     false_pos = tf.reduce_sum((1-y_true_pos)*y_pred_pos)
#     alpha = 0.7
#     return (true_pos + smooth)/(true_pos + alpha*false_neg + (1-alpha)*false_pos + smooth)

# def tversky_loss(y_true, y_pred):
#     return 1 - tversky(y_true,y_pred)


# def focal_tversky_loss(y_true,y_pred):
#     #y_true = y_true.astype('float32')
#     y_true = tf.cast(y_true, tf.float32)
#     y_true = tf.cast(y_true, "float32")
#     tf.cast(y_true, "float32")
#     print(y_true)
#     print(y_pred)
#     pt_1 = tversky(y_true, y_pred)
#     gamma = 0.75
#     return tf.keras.backend.pow((1-pt_1), gamma)

# def mask_to_rle(mask):
#     '''
#     Convert a mask into RLE
    
#     Parameters: 
#     mask (numpy.array): binary mask of numpy array where 1 - mask, 0 - background

#     Returns: 
#     sring: run length encoding 
#     '''
#     pixels= mask.T.flatten()
#     pixels = np.concatenate([[0], pixels, [0]])
#     runs = np.where(pixels[1:] != pixels[:-1])[0] + 1
#     runs[1::2] -= runs[::2]
#     return ' '.join(str(x) for x in runs)


# model = ResUNet(img_h=img_h, img_w=img_w)
# adam = tf.keras.optimizers.Adam(lr = 0.05, epsilon = 0.1)
# model.compile(optimizer=adam, loss=focal_tversky_loss, metrics=[tversky])
# model.summary()


# if load_pretrained_model:
#     try:
#         model.load_weights(pretrained_model_path)
#         print('pre-trained model loaded!')
#     except OSError:
#         print('You need to run the model and load the trained model')




# def remove_small_regions(img, size):
#     """Morphologically removes small (less than size) connected regions of 0s or 1s."""
#     img = morphology.remove_small_objects(img, size)
#     img = morphology.remove_small_holes(img, size)
#     return img


# # a function to apply all the processing steps necessery to each of the individual masks
# def process_pred_mask(pred_mask):
    
#     pred_mask = cv2.resize(pred_mask.astype('float32'),(100, 100))
#     pred_mask = (pred_mask > .5).astype(int)
#     pred_mask = remove_small_regions(pred_mask, 0.02 * np.prod(512)) * 255
#     pred_mask = mask_to_rle(pred_mask)
    
#     return pred_mask



# # return tensor in the right shape for prediction 
# def get_test_tensor(img_dir, img_h, img_w, channels=1):

#     X = np.empty((1, img_h, img_w, channels))
#     # Store sample
#     image = cv2.imread(img_dir, 0)
#     image_resized = cv2.resize(image, (img_w, img_h))
#     image_resized = np.array(image_resized, dtype=np.float64)
#     # normalize image
#     image_resized -= image_resized.mean()
#     image_resized /= image_resized.std()
    
#     X[0,] = np.expand_dims(image_resized, axis=2)

#     return X

# # loop over all the test images
# i=0
# for f in test_files:
#     i+=1
#     # get test tensor, output is in shape: (1, 256, 512, 3)
#     test = get_test_tensor(f, 64, 64) 
#     # get prediction, output is in shape: (1, 256, 512, 4)
#     pred_masks = model.predict(test) 
#     # get a list of masks with shape: 256, 512
#     pred_masks = [pred_masks[0][...,i] for i in range(0,4)]
#     # apply all the processing steps to each of the mask
#     print(pred_masks)
#     pred_masks = [process_pred_mask(pred_mask) for pred_mask in pred_masks]
#     # get our image id
#     id = f.split('/')[-1]
#     # create ImageId_ClassId and get the EncodedPixels for the class ID, and append to our submissions list
#     [submission.append((id+'_%s' % (k+1), pred_mask)) for k, pred_mask in enumerate(pred_masks)]
#     #if i == 5:
#     #    break


# # convert to a csv
# submission_df = pd.DataFrame(submission, columns=['ImageId_ClassId', 'EncodedPixels'])
# # check out some predictions and see if RLE looks ok
# submission_df[ submission_df['EncodedPixels'] != ''].head()



# # take a look at our submission 
# submission_df.head()



# # write it out
# submission_df.to_csv('./submission.csv', index=True)
# # %%



