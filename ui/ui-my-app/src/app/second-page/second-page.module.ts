import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { SecondPagePageRoutingModule } from './second-page-routing.module';

import { SecondPagePage } from './second-page.page';
import { ComponentModule } from '../component/component/component.module';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    SecondPagePageRoutingModule,
    ComponentModule
  ],
  declarations: [SecondPagePage]
})
export class SecondPagePageModule {}
