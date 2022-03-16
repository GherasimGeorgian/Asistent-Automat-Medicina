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
def generate_gif(images_path):
    frames = []
    

    for i in images_path:
        new_frame = Image.open(i)
        frames.append(new_frame)
    frames[0].save('C:/Users/Ghera/source/repos/test_flask_python/app/source/files/gifus.gif',format='GIF',append_images=frames[1:],save_all=True,duration=300,loop=0)

def generate_gif_segmentation(images_path):
    frames = []
    

    for i in images_path:
        new_frame = Image.open(i)
        frames.append(new_frame)
    frames[0].save('C:/Users/Ghera/source/repos/test_flask_python/app/source/files/segm.gif',format='GIF',append_images=frames[1:],save_all=True,duration=1000,loop=0)
colors = np.random.uniform(0,255,size=(5,3))
def generate_gif_bladder_full_size(segm_images,full_images,list_roi_loc):
    frames = []
    files ="C:/Users/Ghera/source/repos/test_flask_python/app/source/files/full_bladder"
    os.chmod(files, stat.S_IRUSR | stat.S_IWUSR | stat.S_IXUSR)
    shutil.rmtree(files, ignore_errors=False)
        
    print("Files deleted")
    directory = "full_bladder"
    
    parent_dir = "C:/Users/Ghera/source/repos/test_flask_python/app/source/files/"
    
    path = os.path.join(parent_dir, directory)
    os.mkdir(path)
    nr_img=0
    for x,y,z in zip(segm_images,full_images,list_roi_loc):
        nr_img+=1
        image = cv2.imread(y)
        im2 = cv2.imread(x)
        color = colors[0]
        cv2.rectangle(image,(z[0],z[1]),(z[0]+z[2],z[1]+z[3]),color,2)
        im2 = cv2.resize(im2, (z[3]+20, z[2]+20))
        image[z[1]:z[1]+z[3]+20, z[0]:z[0]+z[2]+20] = im2
        cv2.imwrite(os.path.join("C:/Users/Ghera/source/repos/test_flask_python/app/source/files/full_bladder/" , str(nr_img) +'.jpeg'), image) 
        new_frame = Image.open("C:/Users/Ghera/source/repos/test_flask_python/app/source/files/full_bladder/" + str(nr_img) +'.jpeg')
        frames.append(new_frame)

    
        

    frames[0].save('C:/Users/Ghera/source/repos/test_flask_python/app/source/files/segm_full.gif',format='GIF',append_images=frames[1:],save_all=True,duration=500,loop=0)
        
        
    
