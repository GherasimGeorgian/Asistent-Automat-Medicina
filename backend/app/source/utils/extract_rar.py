import patoolib
import stat
import shutil
from PIL import Image
import os, os.path
import os
import glob
def extract_files():
    
    

    files ="C:/Users/Ghera/source/repos/test_flask_python/app/source/files/images"
    os.chmod(files, stat.S_IRUSR | stat.S_IWUSR | stat.S_IXUSR)
    shutil.rmtree(files, ignore_errors=False)

    print("File deleted")
    directory = "images"
  
    parent_dir = "C:/Users/Ghera/source/repos/test_flask_python/app/source/files/"
  
    path = os.path.join(parent_dir, directory)
    os.mkdir(path)
    
    patoolib.extract_archive("C:/Users/Ghera/source/repos/test_flask_python/app/source/files/patient1.rar", outdir="C:/Users/Ghera/source/repos/test_flask_python/app/source/files/images")




    imgs_ids = []
    imgs_paths = []
    path = "C:/Users/Ghera/source/repos/test_flask_python/app/source/files/images/pacient1"
    for f in os.listdir(path):
        imgs_ids.append(int((f.split("img")[1]).split(".")[0]))
    for el in sorted(imgs_ids):
        imgs_paths.append(path+ "/"+ "img" + str(el) + ".jpeg")

    return imgs_paths
