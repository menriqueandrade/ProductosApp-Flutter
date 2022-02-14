// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names, unnecessary_this, curly_braces_in_flow_control_structures
//asegurarnos de que sea dart.io 
import 'dart:io';

import 'package:flutter/material.dart';

class ProductEditImage extends StatelessWidget {
  final String? url;

  const ProductEditImage({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 35),
      child: Container(
        decoration: _BoxDecorationEdit(),
        width: double.infinity,
        height: 230,
        /*ClipRRect sirve para dar efecto redondeado alos cards*/
        child: Opacity(
          opacity: 0.9,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45)),
            child: obtenerImagen(url),
          ),
        ),
      ),
    );
  }

  BoxDecoration _BoxDecorationEdit() => BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 5))
          ]);

  Widget obtenerImagen(String? picture) {
    /*De esta manera enviamos el mostramos si la la imagene esta vacia una ves seleccionado el producto*/
    if (picture == null)
      return Image(
        image: AssetImage('assets/no-image.png'),
        fit: BoxFit.cover,
      );
    if (picture.startsWith('http')) 
      return FadeInImage(
        placeholder: AssetImage('assets/loading2.gif'),
    /*Mostramos la imagen que se selecciono anteriormente*/
        image: NetworkImage(this.url!),
        fit: BoxFit.cover,
      );

    return Image.file(
      File(picture),
      fit: BoxFit.cover,
    );
  }
}
