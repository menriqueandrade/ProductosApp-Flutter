// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:productos_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      body: ListView.builder(
        /*Para mostrar un listado de items de manera peresosa*/
        itemCount: 10,
        /*Se trae el product card desde los widgets de esta manera para que se vea en el home*/
        itemBuilder: (BuildContext context, int index) => ProductCard()
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){

          },
        ),
    );
  }
}
