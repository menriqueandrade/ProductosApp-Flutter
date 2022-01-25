// ignore_for_file: unnecessary_new, avoid_print, recursive_getters, prefer_final_fields, unnecessary_getters_setters

import 'package:flutter/material.dart';

/*manejo de clases y atributos*/
class LoginFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey= new GlobalKey<FormState>();

  String email = '';
  String password = '';


  /*Simulacion de tiempo de espera de un http*/
  bool _estaCargando = false;
  bool get estaCargando => _estaCargando;
  set estaCargando(bool value){

    _estaCargando=value;
    notifyListeners();

  }

  bool esValidoFormulario() {

    print(formKey.currentState?.validate());
    print('$email - $password');

    return formKey.currentState?.validate() ?? false;
  }

}
