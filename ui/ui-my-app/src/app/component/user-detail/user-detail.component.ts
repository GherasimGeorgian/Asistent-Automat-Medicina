import { Component, Input, OnInit, Output,EventEmitter } from '@angular/core';

@Component({
  selector: 'app-user-detail',
  templateUrl: './user-detail.component.html',
  styleUrls: ['./user-detail.component.scss'],
})
export class UserDetailComponent implements OnInit {

  @Input('fromParentData') fromParentData:any

  @Output() itemFromComponent = new EventEmitter();
  constructor() { }

  ngOnInit(): void {
    console.log("inside component",this.fromParentData)
  }

  onClick(typeContent:string){
    console.log(typeContent)
    this.itemFromComponent.emit(typeContent)
  }
}
