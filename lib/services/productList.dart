import 'package:flutter/material.dart';
import 'package:onlineshop/model/product.dart';

class ProductList {
  List<Product> products = [
    Product(
        id: 1,
        title: "Bag",
        price: 100,
        size: 12,
        description:
            "Dengan tas Gucci berwarna coklat, Anda tidak hanya membawa barang-barang Anda dengan gaya, tetapi juga mengungkapkan rasa selera fesyen dan status Anda yang tinggi ",
        images: "assets/images/Bags.jpg",
        color: Color(0xFF3D82AE)),
    Product(
        id: 2,
        title: "Sweter",
        price: 234,
        size: 8,
        description:
            "Jaket bomber coklat tipe ini populer karena gayanya yang kasual dan cocok untuk berbagai kesempatan",
        images: "assets/images/Jackets.jpg",
        color: Color(0xFFD3A984)),
    Product(
        id: 3,
        title: "Hang Top",
        price: 300,
        size: 10,
        description:
            "Celana donker tipe jeans biasanya memiliki potongan yang klasik dan sederhana, dengan warna yang lebih gelap dibandingkan dengan jeans biasa.",
        images: "assets/images/Pants.jpg",
        color: Color(0xFF989493)),
    Product(
        id: 4,
        title: "Old Fashion",
        price: 140,
        size: 11,
        description:
            "Kemeja merupakan salah satu fashion item yang wajib dimiliki setiap orang. Tidak hanya dikenakan untuk acara formal, kemeja juga bisa di-mix and match untuk tampilan kasual yang lebih santai",
        images: "assets/images/Shirts.jpg",
        color: Color(0xFFE6B398)),
  ];
}
