// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<CartModel> cartModelFromJson(String str) => List<CartModel>.from(json.decode(str).map((x) => CartModel.fromJson(x)));

String cartModelToJson(List<CartModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartModel {
    final int id;
    final String title;
    final int price;

    CartModel({
        required this.id,
        required this.title,
        required this.price,
    });

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        title: json["title"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
    };
}
