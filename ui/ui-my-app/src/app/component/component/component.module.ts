import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { UserDetailComponent } from '../user-detail/user-detail.component';
import { ProfileImgComponent } from '../profile-img/profile-img.component';
import { IonicModule } from '@ionic/angular';



@NgModule({
  declarations: [ProfileImgComponent,UserDetailComponent],
  imports: [
    CommonModule,IonicModule
  ],
  exports: [ProfileImgComponent,UserDetailComponent]
})
export class ComponentModule { }
