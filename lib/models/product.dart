// To parse this JSON data, do
//
//     final product = productFromMap(jsonString);

// ignore_for_file: unnecessary_this, non_constant_identifier_names

import 'dart:convert';



class Product {
  Product({
    required this.available,
    required this.name,
    this.picture,
    required this.price,
    this.id
  });

  bool available;
  String name;
  String? picture;
  double price;
  String? id;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        available: json["available"],
        name: json["name"],
        picture: json["picture"],
        price: (json["price"]).toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "available": available,
        "name": name,
        "picture": picture,
        "price": price,
      };

  /*Copia del modelo*/
      Product Copia() => Product(
       available: this.available,
       name: this.name,
       picture: this.picture,
       price:this.price,
       id :this.id,
      );
}
