import dicom2nifti
import dicom2nifti.settings as settings
import os

path_pacient_in = "C:/Users/Ghera/Desktop/pacient1"

path_pacient_out = "C:/Users/Ghera/Desktop/out_pacient"




settings.disable_validate_slice_increment()

#dicom2nifti.convert_directory(dicom_directory, output_folder)`

dicom2nifti.dicom_series_to_nifti(path_pacient_in,os.path.join(path_pacient_out,'patient_test_1.nii.gz'))