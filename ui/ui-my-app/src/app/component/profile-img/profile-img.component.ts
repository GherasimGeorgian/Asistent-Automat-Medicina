import { Component, OnInit } from '@angular/core';
import { infoList } from 'src/app/dummyJSON/dummyJSON';

@Component({
  selector: 'app-profile-img',
  templateUrl: './profile-img.component.html',
  styleUrls: ['./profile-img.component.scss'],
})
export class ProfileImgComponent implements OnInit {

  //variables
  private dummyInfoList: Object;

  constructor() {
    this.dummyInfoList = infoList;
    console.log(this.dummyInfoList)
   }

  ngOnInit() {}

}
