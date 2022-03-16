import { Component } from '@angular/core';
import { Router } from '@angular/router'
import { sampleData } from '../dummyJSON/dummyJSON';
@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage {

  //variable
  private sameDataHome:any;
  constructor(private router: Router) {
    this.sameDataHome=sampleData;
  }
  onClick(){
    this.router.navigate(["/second-page"])
  }
  fromComponent(event:string){
    console.log("inside parent module",event)
  }
}
