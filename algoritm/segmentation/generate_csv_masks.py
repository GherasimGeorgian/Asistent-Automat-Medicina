
#%%
import numpy as np
import matplotlib.pyplot as plt
import cv2
# Thanks to the authors of: https://www.kaggle.com/paulorzp/rle-functions-run-lenght-encode-decode
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
#img1 =  cv2.imread("C:\\Users\\Ghera\\Desktop\\segmentation\\alte2\\small60.tiff")
#img1 = cv2.imread('C:\\Users\Ghera\\Desktop\\segmentation\\realdata\\mask_perete\\27_small.tiff')
#img1 = cv2.imread("C:/Users/Ghera/Desktop/testBladder/4444_mask.jpg")
#img1 = cv2.imread("C:/Users/Ghera/Desktop/sasda/kaggle_3m/TCGA_CS_4941_19960909/TCGA_CS_4941_19960909_14_mask.tif")
#img1 = cv2.imread("C:/Users/Ghera/Desktop/segmentation/right_rotating_images_mask/small35.tiff")

#plt.imshow(img1)
#plt.show()

# img2 = cv2.imread("C:/Users/Ghera/Desktop/testBladder/4444.jpg")
# plt.imshow(img2)
# plt.show()

#pred_mask = mask_to_rle(img1)

#print(pred_mask)

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
print("atat\n")

# img3 = rle_to_mask(pred_mask,100,100)
# plt.imshow(img3)
# plt.show()







import csv
import os
path = "C:/Users/Ghera/Desktop/segmentation/realdata/original/"
dirs = os.listdir(path)
with open('names1.csv', 'w', newline='') as csvfile:
    fieldnames = ['ImageId', 'ClassId','EncodedPixels','ImageId_ClassId']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

    writer.writeheader()

    for item in dirs:
        if os.path.isfile(path+item):
            print((item.split('small')[1]).split('.')[0])
            img1 = cv2.imread('C:\\Users\Ghera\\Desktop\\segmentation\\realdata\\mask_perete\\'+(item.split('small')[1]).split('.')[0]+'_small.tiff')
            pred_mask_class1 = mask_to_rle(img1)
            if len(pred_mask_class1)>0:
                writer.writerow({'ImageId': item, 'ClassId': 1,'EncodedPixels':pred_mask_class1,'ImageId_ClassId':item+'_1'})
            #else:
            #    writer.writerow({'ImageId': item, 'ClassId': 2,'EncodedPixels':'0 0','ImageId_ClassId':item+'_2'})


            img2 = cv2.imread('C:\\Users\Ghera\\Desktop\\segmentation\\realdata\\mask_tumoare\\'+(item.split('small')[1]).split('.')[0]+'_small.tiff')
            pred_mask_class2 = mask_to_rle(img2)
            if len(pred_mask_class2)>0:
                writer.writerow({'ImageId': item, 'ClassId': 2,'EncodedPixels':pred_mask_class2,'ImageId_ClassId':item+'_2'})
            #else:
            #    writer.writerow({'ImageId': item, 'ClassId': 2,'EncodedPixels':'0 0','ImageId_ClassId':item+'_2'})
                
    #writer.writerow({'ImageId': 'Lovely', 'ClassId': 'Spam','EncodedPixels':'','ImageId_ClassId':''})
    #writer.writerow({'ImageId': 'Wonderful', 'ClassId': 'Spam','EncodedPixels':'','ImageId_ClassId':''})







# %%
