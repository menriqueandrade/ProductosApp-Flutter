// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'Productos App',
      
      initialRoute: 'login',
      routes: {
        'login':( _ ) => LoginScreen(),
        'home':( _ ) => HomeScreen(),
      },
      /*Con esto el la aplicacion principal tendra el color que nosotros querramos*/
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        /*Cambiar colores del app bar de forma global*/
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.indigo
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
          elevation: 0,
        )
      ),
    );
  }
}

