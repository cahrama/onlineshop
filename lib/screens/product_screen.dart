import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:onlineshop/services/firestore_service.dart';
import 'package:onlineshop/widgets/bottom_sheet.dart';

class ProductScreen extends StatefulWidget {
  final String namedetail;
  final String imagedetail;
  final String pricedetail;
  final String detail;
  final String id;
  final Map<String, dynamic> data;
  ProductScreen(this.namedetail, this.imagedetail, this.pricedetail,
      this.detail, this.id, this.data);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final FirestoreService firestore_service = FirestoreService();

  TextEditingController gambarController = TextEditingController();

  TextEditingController namaController = TextEditingController();

  TextEditingController hargaController = TextEditingController();

  TextEditingController deskripsiController = TextEditingController();

  TextEditingController kategoriController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> _showEditDialog(String id, Map<String, dynamic> data) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          gambarController.text = data['gambar'];
          namaController.text = data['namabarang'];
          hargaController.text = data['hargabarang'];
          deskripsiController.text = data['deskripsi'];
          kategoriController.text = data['category'];

          return AlertDialog(
            scrollable: true,
            title: const Text('Edit Item'),
            content: SingleChildScrollView(
              // Add this line
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: gambarController,
                    decoration: const InputDecoration(labelText: 'URL Gambar'),
                  ),
                  TextField(
                    controller: namaController,
                    decoration: const InputDecoration(labelText: 'Nama Barang'),
                  ),
                  TextField(
                    controller: hargaController,
                    decoration:
                        const InputDecoration(labelText: 'Harga Barang'),
                  ),
                  TextField(
                    controller: deskripsiController,
                    decoration:
                        const InputDecoration(labelText: 'Deskripsi Barang'),
                  ),
                  TextField(
                    controller: kategoriController,
                    decoration:
                        const InputDecoration(labelText: 'Kategori Barang'),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  FirestoreService().updateHome(
                    id,
                    gambarController.text,
                    namaController.text,
                    hargaController.text,
                    deskripsiController.text,
                    kategoriController.text,
                  );
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Ubah'),
              ),
            ],
          );
        },
      );
    }

    Future<void> _showHapusDialog(String id) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Hapus Item'),
            content: Text("Are You Sure ??"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  FirestoreService().deleteHome(
                    id,
                  );
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Hapus'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height / 2.0,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 224, 224, 224),
                image: DecorationImage(
                  image: NetworkImage(widget.imagedetail),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 22,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.favorite,
                          size: 22,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(top: 8, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.namedetail,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "\$${widget.pricedetail}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.red.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(height: 15),
                  //Rating Bar
                  RatingBar.builder(
                    unratedColor: Colors.grey,
                    itemSize: 28,
                    initialRating: 3.5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4),
                    onRatingUpdate: (rating) {},
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    widget.detail,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _showEditDialog(widget.id, widget.data);
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            "Edit",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _showHapusDialog(widget.id);
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            "Hapus",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return CustomBottomSheet(
                                  widget.pricedetail,
                                  widget.imagedetail,
                                  widget.namedetail,
                                  widget.detail);
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 50),
                          decoration: BoxDecoration(
                            color: Color(0xFFFD725A),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            "Buy Now",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
