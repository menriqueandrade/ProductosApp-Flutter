// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables, unnecessary_this

import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final Widget child;

  const CardContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*Para que el Card quede centrado de manera organizada se agrega un padding symetrico que todos sus lados son iguales*/
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        //height: 300, Con esto le damos el tamaño al Card
        /*Hacemos para el padding para que nada quede pegado en el card*/
        padding: EdgeInsets.all(20),
        /*Se hace el card un metodo para trabajar con el mejor y agregarle mas atributos*/
        decoration: _CreacionCard(),
        /*el child es la variable que nos va dejar hacer cosas dentro del card solamente*/
        child: this.child,
      ),
    );
  }

  BoxDecoration _CreacionCard() => BoxDecoration(
          /*Aca podemos trabajar atributos de el card en especifico*/
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          /*Shadow sirve para darle sombra al Card*/
          boxShadow: [
            BoxShadow(color: Colors.black12,
             blurRadius: 15,
             /*Con el offset podemos maneras las sombras con el eje x y */
             offset: Offset(0,5),
             )
          ]);
}
