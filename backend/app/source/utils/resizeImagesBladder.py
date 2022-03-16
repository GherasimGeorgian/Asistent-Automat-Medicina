
from PIL import Image,ImageDraw
import glob
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
from numpy import append
import cv2
import numpy as np
import os
import stat
import shutil

def resizeImagesBladder(path_images):
    
    files ="C:/Users/Ghera/source/repos/test_flask_python/app/source/files/gif_images"
    os.chmod(files, stat.S_IRUSR | stat.S_IWUSR | stat.S_IXUSR)
    shutil.rmtree(files, ignore_errors=False)

    print("File deleted")
    directory = "gif_images"
  
    parent_dir = "C:/Users/Ghera/source/repos/test_flask_python/app/source/files/"
  
    path = os.path.join(parent_dir, directory)
    os.mkdir(path)
    list_paths=[]
    x = 1
    for i in path_images:
        img1 = cv2.imread(i)
        resized_image = cv2.resize(img1, (100, 100))
      
        cv2.imwrite(os.path.join("C:/Users/Ghera/source/repos/test_flask_python/app/source/files/gif_images/" , str(x) +'.jpeg'), resized_image) 
        list_paths.append("C:/Users/Ghera/source/repos/test_flask_python/app/source/files/gif_images/"  + str(x) +'.jpeg')
        x+=1
    return list_paths



    