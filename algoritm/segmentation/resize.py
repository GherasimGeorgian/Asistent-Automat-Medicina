from PIL import Image
import os

path = "C:/Users/Ghera/Desktop/segmentation/realdata/create/"
dirs = os.listdir(path)

def resize():
    for item in dirs:
        if item == '.tiff':
            continue
        if os.path.isfile(path+item):
            image = Image.open(path+item)
            file_path, extension = os.path.splitext(path+item)
            size = image.size

            new_image_height = 100
            new_image_width = 100
            #Image.NEAREST --fara nuante de grey 
            image = image.resize((new_image_height, new_image_width), Image.NEAREST)
            image.save(file_path + "_small" + extension, 'tiff', quality=90)
            print("ok")


resize()