import numpy as np 
import pydicom
from PIL import Image
import os
user = "vadean"
def convert_dcm_jpg(name):
   im = pydicom.dcmread("C:/Users/Ghera/Desktop/real data ai/Original/"+user+"/dicom/"+name)

   im = im.pixel_array.astype(float)

   rescaled_image = (np.maximum(im,0)/im.max())*255
   final_image = np.uint8(rescaled_image)
   final_image = Image.fromarray(final_image)
   return final_image


import os
def get_names(path):
    names=[]
    for root,dirnames,filenames in os.walk(path):
        for filename in filenames:
            _,ext = os.path.splitext(filename)
            if ext in ['.dcm']:
                names.append(filename)
    return names

names = get_names("C:/Users/Ghera/Desktop/real data ai/Original/"+user+"/dicom/")
for name in names:
    print(name)

    image= convert_dcm_jpg(name)
    new_image_height = 100
    new_image_width = 100
            
    image = image.resize((new_image_height, new_image_width))

    image.save("C:/Users/Ghera/Desktop/real data ai/Original/"+user+"/jpg/" + name + '.jpg')