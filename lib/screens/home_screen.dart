// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    /*Si quiere ver los productos aca en esta pantalla se digita este codigo para verlos*/
    final productsService = Provider.of<ProductsService>(context);

    /*Esta condicion espara cuando el loading esta en true saldra una barra de carga */
    if (productsService.estaCargando) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      body: ListView.builder(
        /*Para mostrar un listado de items de manera peresosa*/
        itemCount: productsService.products.length,
        /*Se trae el product card desde los widgets de esta manera para que se vea en el home*/
        itemBuilder: (BuildContext context,
            int index) => /*Con el gesture detector podemos ingresar a otra pantalla por medio de una card*/ GestureDetector(
          onTap: () {
            /*De esta manera llevamos la informacion de un producto a otra pantalla */
            productsService.productoSeleccionado =
                productsService.products[index].Copia();
            Navigator.pushNamed(context, 'product', arguments: productsService)
                .then((value) {
              setState(() {});
            });
          },
          child: ProductCard(
            product: productsService.products[index],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          /*De esta manera creamos un producto*/
          productsService.productoSeleccionado =
              new Product(available: false, name: '', price: 0);
          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }
}
