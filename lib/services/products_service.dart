// ignore_for_file: unnecessary_this, avoid_print, non_constant_identifier_names



import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:productos_app/models/product.dart';
/*Ojo tenemos que importar la libreria http manual*/
import 'package:http/http.dart' as http;

/*Usamos esto para obtener los servicios get post de api rest*/
class ProductsService extends ChangeNotifier {

  final String _baseURL = 'flutter-appproductos-default-rtdb.firebaseio.com';
  final List<Product> products = [];

  /*Esto se hace para cargar el producto seleccionado a otra pantalla*/
  late Product productoSeleccionado;

  /*Para agregar imagenes al APP*/
  File? nuevoArchivoImagen;

  bool estaCargando = true;
  /*Para guardar y actualizar*/
  bool estaGuardado = true;

  ProductsService() {
    this.cargarProductos();
  }
  /*Forzar al app que lo que reciba sea solo lista  de productos*/
  Future<List<Product>> cargarProductos() async {

    this.estaCargando= true;
    notifyListeners();

    /*Utilizamos la url que nos dio firebase mediante su variable */
    final url = Uri.https(_baseURL, 'products.json');
    final respuesta= await http.get(url);
    /*cambiar el json y obtenemos el mapa */
    final Map<String, dynamic> productsMap= json.decode(respuesta.body);
    /*Convertimos el mapa en un listado*/

    productsMap.forEach((key, value) {
      final productoTemporal = Product.fromMap(value);
      productoTemporal.id = key;
      this.products.add(productoTemporal);
    });

    this.estaCargando= false;
    notifyListeners();
    return this.products;

  }

  /*Con este mismo metodo me sirve para actualizar y guardar*/
  Future GuardarOCrearProductos(Product product) async {

    estaGuardado = true;
    notifyListeners();

    if( product.id == null ){
      //Es necesario crear el producto    
      await this.crearProducto(product);

    }else{
      //Se actualiza
      this.actualizarProducto(product);
    }



    estaGuardado= false;
    notifyListeners();

  }

  Future<String>actualizarProducto(Product product) async{

    final url = Uri.https(_baseURL, 'products/${product.id}.json');
    final respuesta= await http.put(url, body: product.toJson());
    final decodedData = respuesta.body;
    print(decodedData);
    /*Aca se actualiza el listado de productos*/
    final index = this.products.indexWhere((element) => element.id == product.id);
    this.products[index] = product;

    return product.id!;
  }

  Future<String> crearProducto (Product product) async{

    final url = Uri.https(_baseURL, 'products.json');
    final respuesta= await http.post(url, body: product.toJson());
    final decodedData = json.decode(respuesta.body);
    print(decodedData);
    /*Aca se crea el listado de productos*/
    product.id =decodedData['name'];
    this.products.add(product);

    return product.id!;
  }


  /*Esto es para mostrar la imagen que se tomo y meterla en el app*/
  void actualizarImagenProductoSeleccionado(String path){
    this.productoSeleccionado.picture= path;
    /*Con esto tenemos el archivo*/
    this.nuevoArchivoImagen= File.fromUri(Uri(path: path));

    /*para reinicioar todos los que estane escuchando*/
    notifyListeners();
  }
  /*Subir imagenes en cloudinary y mostrar en la app*/
  Future<String?> subirImagenes() async{

    if (this.nuevoArchivoImagen == null)return null;

    this.estaGuardado = true;
    notifyListeners();
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dwwwryqzg/image/upload?upload_preset=l0icgvqy');

    final imagenRespuestaSubida = http.MultipartRequest(
      'POST', url);
    final file = await http.MultipartFile.fromPath('file', nuevoArchivoImagen!.path);

    imagenRespuestaSubida.files.add(file);

    final streamedResponse = await imagenRespuestaSubida.send();

    final respuesta = await http.Response.fromStream(streamedResponse);
    
    if (respuesta.statusCode != 200 && respuesta.statusCode != 201) {
      print('Algo salio mal');
      print(respuesta.body);
      return null;
    }

    this.nuevoArchivoImagen= null;

    final decodedData=  json.decode(respuesta.body);
    return decodedData['secure_url'];
  

  }
  



  Future<String>eliminarProducto(Product product) async{

    final url = Uri.https(_baseURL, 'products/${product.id}.json');
    final respuesta= await http.delete(url, body: product.toJson());
    final decodedData = respuesta.body;
    print(decodedData);
    /*Aca se actualiza el listado de productos*/
    final index = this.products.indexWhere((element) => element.id == product.id);
    this.products[index] = product;

    return product.id!;
  }
}
