import os
import cv2
import numpy as np
import glob
import random
#import pydicom as dicom
import matplotlib.pyplot as plt
import stat
import shutil

def localization2(images):
    nr_img = 1;
    
    
    list_roi_loc=[]
    avg_x =0
    avg_y=0
    avg_h=0
    avg_w=0
    avg_conf=0
    for path_img in images:
        # Load Yolo
        net = cv2.dnn.readNet("C:\\Users\\Ghera\\source\\repos\\ai-bladder-tumor\\yolov4-obj_last.weights", "C:\\Users\\Ghera\\source\\repos\\ai-bladder-tumor\\yolov4-obj.cfg")

        # Name custom object
        classes = ["bladder"]

        my_img = cv2.imread(path_img)
        #my_img = cv2.resize(my_img,(1280,720))
        wt,ht,_ = my_img.shape

        blob = cv2.dnn.blobFromImage(my_img,1/255,(416,416),(0,0,0,0),swapRB = True,crop = False)

        net.setInput(blob)

        last_layer = net.getUnconnectedOutLayersNames()

        layer_out = net.forward(last_layer)

        boxes=[]
        confidences=[]
        class_ids=[]

        for output in layer_out:
            for detection in output:
                score = detection[5:]
                classid= np.argmax(score)
                confidence = score[classid]
                if confidence > .6:
                    center_x = int(detection[0]*wt)
                    center_y = int(detection[1]*ht)
                    w = int(detection[2]*wt)
                    h = int(detection[2]*ht)

                    x = int(center_x - w/2)
                    y = int(center_y - h/2)
                    boxes.append([x,y,w,h])
                    confidences.append((float(confidence)))
                    class_ids.append(classid)
        indexes = cv2.dnn.NMSBoxes(boxes,confidences,.5,.4)
        print(indexes)
        font = cv2.FONT_HERSHEY_PLAIN
        colors = np.random.uniform(0,255,size=(len(boxes),3))

        i = indexes.flatten()[0];
        #for i in indexes.flatten():
        x,y,w,h = boxes[i]
        label = str(classes[class_ids[i]])
        confidence = round(confidences[i],2)
        avg_x+=x
        avg_y+=y
        avg_w+=w
        avg_h+=h
        avg_conf+=confidence
        nr_img+=1  
        
    avg_h = int(avg_h /nr_img)
    avg_x = int(avg_x /nr_img)
    avg_y = int(avg_y /nr_img)
    avg_w = int(avg_w /nr_img)
    avg_conf = str(avg_conf /nr_img)
    return [avg_x,avg_y,avg_w,avg_h,avg_conf]
    


def localization(images):
    nr_img = 1;
    files ="C:/Users/Ghera/source/repos/test_flask_python/app/source/files/gif_images"
    os.chmod(files, stat.S_IRUSR | stat.S_IWUSR | stat.S_IXUSR)
    shutil.rmtree(files, ignore_errors=False)
    list_imgs=[]
    list_roi_loc=[]
    print("File deleted")
    directory = "gif_images"
  
    parent_dir = "C:/Users/Ghera/source/repos/test_flask_python/app/source/files/"
  
    path = os.path.join(parent_dir, directory)
    os.mkdir(path)
    for path_img in images:
        # Load Yolo
        net = cv2.dnn.readNet("C:\\Users\\Ghera\\source\\repos\\ai-bladder-tumor\\yolov4-obj_last.weights", "C:\\Users\\Ghera\\source\\repos\\ai-bladder-tumor\\yolov4-obj.cfg")

        # Name custom object
        classes = ["bladder"]

        my_img = cv2.imread(path_img)
        #my_img = cv2.resize(my_img,(1280,720))
        wt,ht,_ = my_img.shape

        blob = cv2.dnn.blobFromImage(my_img,1/255,(416,416),(0,0,0,0),swapRB = True,crop = False)

        net.setInput(blob)

        last_layer = net.getUnconnectedOutLayersNames()

        layer_out = net.forward(last_layer)

        boxes=[]
        confidences=[]
        class_ids=[]

        for output in layer_out:
            for detection in output:
                score = detection[5:]
                classid= np.argmax(score)
                confidence = score[classid]
                if confidence > .6:
                    center_x = int(detection[0]*wt)
                    center_y = int(detection[1]*ht)
                    w = int(detection[2]*wt)
                    h = int(detection[2]*ht)

                    x = int(center_x - w/2)
                    y = int(center_y - h/2)
                    boxes.append([x,y,w,h])
                    confidences.append((float(confidence)))
                    class_ids.append(classid)
        indexes = cv2.dnn.NMSBoxes(boxes,confidences,.5,.4)
        print(indexes)
        font = cv2.FONT_HERSHEY_PLAIN
        colors = np.random.uniform(0,255,size=(len(boxes),3))

        i = indexes.flatten()[0];
        #for i in indexes.flatten():
        x,y,w,h = boxes[i]
        label = str(classes[class_ids[i]])
        confidence = str(round(confidences[i],2))
        color = colors[i]
        #cv2.rectangle(my_img,(x,y-20),(x+w,y+h),color,2)
        list_roi_loc.append([x,y,w,h])    
        #cv2.putText(my_img,label + " " + confidence,(x,y),font,2,(255,255,255),2)
        #cv2.imshow('img',my_img)
        gray = cv2.cvtColor(my_img, cv2.COLOR_BGR2GRAY)
        roi_image = gray[y:y+h + 20, x:x+w+20]
        #cv2.imshow('roiimg',roi_image)
        resized_image = cv2.resize(roi_image, (100, 100))
        cv2.imwrite(os.path.join("C:/Users/Ghera/source/repos/test_flask_python/app/source/files/gif_images/" , str(nr_img) +'.jpeg'), resized_image) 
        pth = "C:/Users/Ghera/source/repos/test_flask_python/app/source/files/gif_images/" + str(nr_img) + ".jpeg"
        list_imgs.append(pth)
        cv2.waitKey(0)
        nr_img+=1
        

        #cv2.destroyAllWindows()
    return list_imgs,list_roi_loc
    