import 'package:flutter/material.dart';
import 'package:onlineshop/widgets/cart_item_sample.dart';

class CartScreen extends StatelessWidget {
  final String namedetail;
  final String imagedetail;
  final String pricedetail;
  final String detail;

  CartScreen(this.pricedetail, this.namedetail, this.detail, this.imagedetail);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 271,
        child: BottomDetail(pricedetail: pricedetail),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              // Appbar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 22,
                      ),
                    ),
                    Text("Cart",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        )),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.more_horiz,
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    CartItemSamples(
                        namedetail, imagedetail, pricedetail, detail),
                    SizedBox(height: 30),
                    // Bottom detail
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomDetail extends StatelessWidget {
  const BottomDetail({
    super.key,
    required this.pricedetail,
  });

  final String pricedetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Select All",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Checkbox(
                activeColor: Color(0xFFFD725A),
                value: true,
                onChanged: (value) {},
              ),
              // Container(
              //   height: 70,
              //   width: 70,
              //   margin: EdgeInsets.only(right: 15),
              //   decoration: BoxDecoration(
              //     color: Color.fromARGB(255, 224, 224, 224),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Image.network(imagedetail),
              // )
            ],
          ),
        ),
        SizedBox(height: 15),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Delivery Cost Payment:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              Text(
                "\$${pricedetail}",
                style: TextStyle(
                  color: Color(0xFFFD725A),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Payment:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              Text(
                "\$${pricedetail}",
                style: TextStyle(
                  color: Color(0xFFFD725A),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
            decoration: BoxDecoration(
              color: Color(0xFFFD725A),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              "Checkout",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
