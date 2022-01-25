// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_const_constructors, unnecessary_this

import 'package:flutter/material.dart';

class Authbackground extends StatelessWidget {
  /*Lo usamos abajo del icono */
  final Widget child;
  const Authbackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      /*Para poner color a toda la pantalla*/
      //color: Colors.red,
      width: double.infinity,
      height: double.infinity,
      /*El stack es para poner widgets ensima de otros*/
      child: Stack(
        children: [
          /*De esta manera llamo el widget que voy a ultilzar */
          _ColorPurpuraBox(),
          /*Este container lleva el area del icono */
          _IconoDeArriba(),
          this.child,
        ],
      ),
    );
  }
}

class _IconoDeArriba extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        /*De esta manera separo el icono de arriba */
        margin: EdgeInsets.only(top: 10),
        child: Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}

class _ColorPurpuraBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*creamos variable para el tamaño */
    final size = MediaQuery.of(context).size;
    return Container(
      /*Para ocupar toda la pantalla*/
      width: double.infinity,
      /*Todo el ancho que se pueda*/
      /*aca multiplicamos la variable size para que salga solo en 40% de la pantalla de purpura*/
      height: size.height * 0.4,
      /*Color con gradiente*/
      decoration: _gradientePurpura(),
      child: Stack(
        children: [
          /*Para cambiar posiciones dentro de un stack se usa esto*/
          Positioned(
            child: _Burbujas(),
            top: 90,
            left: 200,
          ),
          Positioned(
            child: _Burbujas(),
            top: 150,
            left: 300,
          ),
          Positioned(
            child: _Burbujas(),
            top: -50,
            left: 120,
          ),
          Positioned(
            child: _Burbujas(),
            bottom: -50,
            left: 10,
          ),
          Positioned(
            child: _Burbujas(),
            bottom: 120,
            left: 20,
          ),
        ],
      ),
    );
  }

  BoxDecoration _gradientePurpura() => BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(63, 63, 156, 1),
        Color.fromRGBO(90, 70, 178, 1)
      ]));
}

/*Burbujas de la box purpura*/
class _Burbujas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );
  }
}
