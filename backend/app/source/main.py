import io
import os
import zipfile
from ai.localizationbladder import localization2
from utils.resizeImagesBladder import resizeImagesBladder
from flask import Flask, request, jsonify,send_file
from ai.map_mask_image import genereate_segmented_images
from utils.gif import generate_gif,generate_gif_bladder_full_size,generate_gif_segmentation
from utils.extract_rar import extract_files
from flask_cors import CORS
from werkzeug.utils import secure_filename
import requests
from ai.localizationbladder import localization
app = Flask(__name__)
cors = CORS(app)

IMAGE_EXTENSION = '.rar'
UPLOAD_FOLDER = './files'

app.config["UPLOAD_FOLDER"] = UPLOAD_FOLDER

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in IMAGE_EXTENSION
    
@app.route('/', methods=['GET'])
def home():
    return 'Hello!'
    
@app.route('/bladder-images', methods=["POST"])  
def processing_image():
    if 'image' not in request.files:
        respond = jsonify({'message': 'Server cannot or will not process the request!'})
        respond.status_code = 400
        return respond

    file = request.files['image']

    if file.filename == '':
        respond = jsonify({'message': 'No file was selected for upload!'})
        respond.status_code = 400
        return respond

    if file and allowed_file(file.filename):
        #filename = secure_filename(file.filename)
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], "patient1.rar"))
        respond = jsonify({'message': 'File successfully uploaded'})
        
    else:
        respond = jsonify({'message': 'Allowed file that are not allowed are: txt, pdf, png, jpg, jpeg, gif!'})
        respond.status_code = 400
        return respond
    images = extract_files();
    parameters = localization2(images)
    
    
    path_images = resizeImagesBladder(images);  
    segm_images = genereate_segmented_images(path_images,parameters)
    
    
    generate_gif_segmentation(segm_images)
    #generate_gif_bladder_full_size(segm_images,images,list_roi_loc)
    # print(images)
    # print(request.files)
    return send_file('C:/Users/Ghera/source/repos/test_flask_python/app/source/files/segm.gif'),201

if __name__ == '__main__':
    app.run()
