import { HttpClient, HttpHeaders, HttpResponse } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';

import { Observable } from 'rxjs';
@Component({
  selector: 'app-second-page',
  templateUrl: 'second-page.page.html',
  styleUrls: ['second-page.page.scss'],
})
export class SecondPagePage implements OnInit {
  base64Imagestring;
  selectedFile: File = null;  
  imageToShow: any;
  isImageLoading = true;
  show=false;
  constructor(public http: HttpClient) { }

  ngOnInit() {
  }

  onFileSelected(event){
    console.log(event)
    this.selectedFile=<File>event.target.files[0];
  }
  createImageFromBlob(image: Blob) {
    let reader = new FileReader();
    reader.addEventListener("load", () => {
       this.imageToShow = reader.result;
    }, false);

    if (image) {
       reader.readAsDataURL(image);
    }
 } 



 
  onUpload(){
    this.show=true;
    const filedata = new FormData();
    filedata.append('image',this.selectedFile,this.selectedFile.name);
   
  //  let HTTPOptions:Object = {

  //   headers: new HttpHeaders({
  //       'Content-Type':'blob'
  //   }),
  //   responseType:'blob',
  //   requestType:'blob',
    
  //   }
    //console.log(gasit,  )
    // const req = this.http.post<any>("http://localhost:5000/bladder-images",filedata, HTTPOptions)
    //  req.subscribe(data => {
    //  this.createImageFromBlob(data);
    //  this.isImageLoading = false;
    // });


    let HTTPOptions2:Object = {

      
      responseType:'blob',
      requestType:'blob',
      
      }
    const req = this.http.post<any>("http://localhost:5000/bladder-images",filedata,HTTPOptions2)
     req.subscribe(data => {
     this.createImageFromBlob(data);
     this.isImageLoading = false;
     this.show=false;
    });
  
  }






  
}
