import 'package:flutter/material.dart';
import 'package:onlineshop/model/product.dart';
import 'package:onlineshop/screens/product_screen.dart';
import 'package:onlineshop/services/firestore_service.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String image;
  final String price;
  final String description;
  String id;
  Map<String, dynamic> data;
  ProductCard({
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.id,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Color.fromARGB(255, 224, 224, 224),
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductScreen(
                              name, image, price, description, id, data),
                        ));
                  },
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    height: 230,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.7)),
                ),
                SizedBox(height: 5),
                Text(
                  "\$${price}",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.red.withOpacity(0.7)),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
