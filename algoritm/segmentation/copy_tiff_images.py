import numpy as np 
import pydicom
from PIL import Image
import os
import cv2
user = "vadean"
type="Tumoare"#Tumoare #Perete
ext_dir ="tiff"
mask_type = "mask_tumoare" #mask_perete #mask_tumoare
import os
def get_names(path):
    names=[]
    for root,dirnames,filenames in os.walk(path):
        for filename in filenames:
            _,ext = os.path.splitext(filename)
            if ext in ['.tiff']:
                names.append(filename)
    return names
def get_last(path):
    list_M=[]
    for root,dirnames,filenames in os.walk(path):
        for filename in filenames:
            _,ext = os.path.splitext(filename)
            list_M.append(int(filename.split("_")[0]))
    return max(list_M)

last =  get_last("C:/Users/Ghera/Desktop/segmentation/realdata/"+mask_type+"/")
print("last:",last)
last_x = int(last)
names = get_names("C:/Users/Ghera/Desktop/real data ai/"+type+"/"+user+"/"+ext_dir+"/")
for name in names:
    print(name)
    image = cv2.imread("C:/Users/Ghera/Desktop/real data ai/"+type+"/"+user+"/"+ext_dir+"/"+name)
    # new_image_height = 100
    # new_image_width = 100
    # #Image.NEAREST --fara nuante de grey 
    # image = image.resize((new_image_height, new_image_width), Image.NEAREST)    
    last_x+=1
   
    cv2.imwrite("C:/Users/Ghera/Desktop/segmentation/realdata/"+mask_type+"/" + str(last_x) + "_small" + '.tiff', image)