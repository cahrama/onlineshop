import 'package:flutter/material.dart';

class Product {
  final String images, title, description;
  final int price, size, id;
  final Color color;

  Product(
      {required this.images,
      required this.title,
      required this.description,
      required this.price,
      required this.size,
      required this.id,
      required this.color});
}
