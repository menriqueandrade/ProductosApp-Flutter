// ignore_for_file: unnecessary_new, avoid_print, unnecessary_this

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';


class ProductFormProvider extends ChangeNotifier{

  /*Aca esta todo para cargar la informacion en un formulario para poder ser editado*/

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Product product;
  ProductFormProvider (this.product);


  actualizarDisponibilidad(bool value){
      print(value);
      this.product.available=value;
      notifyListeners();

  }


  bool estaValidoFormulario(){
    print(product.name);
    print(product.price);
    print(product.available);
    return formKey.currentState?.validate() ?? false;
  }


}