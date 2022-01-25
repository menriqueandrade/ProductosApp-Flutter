// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      /*Para manerjar los bordes uniformes q tengan el mismo tamaño*/
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
          /*Para separar cada uno de los cards*/
          margin: EdgeInsets.only(top: 30, bottom: 10),
          width: double.infinity,
          height: 400,
          decoration: _CardBordes(),
          child: Stack(
            children: [
              _ImagenFondoCard()
              
              ],
          )

          //color: Colors.red,
          ),
    );
  }

  BoxDecoration _CardBordes() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 7),
              blurRadius: 10,
            )
          ]);
}

class _ImagenFondoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*la solucion para que as esquinas se vean con radio circular es agregando Cliprreact y border radius*/
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
          width: double.infinity,
          height: 400,
          child: FadeInImage(
            placeholder: AssetImage('assets/loading2.gif'),
            image: NetworkImage('https://via.placeholder.com/400x300/f6f6f6'),
            /*Con esto el fondo se acomoda al card*/
            fit: BoxFit.cover,
          ),
          
          ),
    );
  }
}

/*child: FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage('https://via.placeholder.com/400x300/f6f6f6'),
        ),*/