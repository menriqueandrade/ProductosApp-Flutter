// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductCard extends StatelessWidget {


  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);



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
            alignment: Alignment.bottomLeft,
            children: [
              _ImagenFondoCard(product.picture),
              _DetallesDeProducto(
                titulo: product.name,
                subTitulo: product.id!,
              ),

              Positioned(
              top: 0,
              /*tag en la derechha right*/
              right: 0,
              child: _TagPrecio(precio: product.price)
              ),

              //Aca se hace una condicion para que este disponible o no 
              if(!product.available)
               Positioned(
              top: 0,
              /*tag en la izquierda left*/
              left: 0,
              child: _NotaDisponibilidad()
              ),
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

class _NotaDisponibilidad extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text("No Disponible",style: TextStyle(color: Colors.white,fontSize: 20),),
          
        ),
      ),
      width: 100,
      height: 70,
      decoration: _TagDisponibilidad(),
    );
  }

  BoxDecoration _TagDisponibilidad() {
    return BoxDecoration(
      color: Colors.yellow[800],
       borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
    );
  }
}

class _TagPrecio extends StatelessWidget {
  
 final double precio;

  const _TagPrecio({required this.precio});

  @override
  Widget build(BuildContext context) {
    return Container(
      /*Para acomodar el precio de arriba*/
      child: FittedBox
      (fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text( '\$$precio', style: TextStyle(color: Colors.white,fontSize: 20),),
        ),
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: _BoxDecorationArriba() ,
    );
  }

  BoxDecoration _BoxDecorationArriba() => BoxDecoration(
     color: Colors.indigo,
        borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
  );
}

class _DetallesDeProducto extends StatelessWidget {

  final String titulo;
  final String subTitulo;

  const _DetallesDeProducto( {
     required this.titulo, required this.subTitulo
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 55,
        decoration: _BoxDecorationAbajo(),
        /*Texto dentro de detalles*/
        child: Column(
          /*Alinear de manera horizontal*/
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              subTitulo,
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            
            
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _BoxDecorationAbajo() => BoxDecoration(
    /*Aca decoramos la parte de abajo de los detalles de el CARD*/
    color: Colors.indigo,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), topRight: Radius.circular(25))
    );
}

class _ImagenFondoCard extends StatelessWidget {
  /*De esta manera mostramos la imagenes en el app*/
  final String? url;
  const _ImagenFondoCard(this.url);

  @override
  Widget build(BuildContext context) {
    /*la solucion para que as esquinas se vean con radio circular es agregando Cliprreact y border radius*/
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: double.maxFinite,
        child: 
        /*Si no hay imagen se hace esta condicion para que no exista el error*/
        url == null ? Image(image: AssetImage('assets/no-image.png'),
        fit: BoxFit.cover,):
        FadeInImage(
          placeholder: AssetImage('assets/loading2.gif'),
           /*De esta manera mostramos la imagenes en el app con la url*/
          image: NetworkImage(url!),
          /*Con esto el fondo se acomoda al card*/
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
