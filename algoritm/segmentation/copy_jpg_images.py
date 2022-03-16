import numpy as np 
import pydicom
from PIL import Image
import os
import cv2
user = "vadean"
type="Original"
ext_dir ="jpg"
mask_type = "original" #mask_perete
import os
def get_names(path):
    names=[]
    for root,dirnames,filenames in os.walk(path):
        for filename in filenames:
            _,ext = os.path.splitext(filename)
            if ext in ['.jpg']:
                names.append(filename)
    return names
def get_last(path):
    list_M=[]
    for root,dirnames,filenames in os.walk(path):
        for filename in filenames:
            _,ext = os.path.splitext(filename)
            print(int((filename.split("small")[1]).split(".")[0]))
            list_M.append(int((filename.split("small")[1]).split(".")[0]))
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
   
    cv2.imwrite("C:/Users/Ghera/Desktop/segmentation/realdata/"+mask_type+"/" + "small" +str(last_x)  + '.jpg', image)