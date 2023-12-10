import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onlineshop/screens/profile.dart';
import 'package:onlineshop/services/firestore_service.dart';
import 'package:onlineshop/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List catList = ["All", "Tas", "Celana", "Jaket", "Kemeja"];
  String selectedCategory = "All";

  final FirestoreService firestore_service = FirestoreService();
  TextEditingController gambarController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController kategoriController = TextEditingController();

  get onTap => null;

  @override
  void dispose() {
    // TODO: implement dispose
    gambarController.dispose();
    namaController.dispose();
    hargaController.dispose();
    deskripsiController.dispose();
    kategoriController.dispose();
    super.dispose();
  }

  Future<void> _showAddDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Produk Baru'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: gambarController,
                  decoration: InputDecoration(labelText: 'URL Gambar'),
                ),
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(labelText: 'Nama Barang'),
                ),
                TextField(
                  controller: hargaController,
                  decoration: InputDecoration(labelText: 'Harga Barang'),
                ),
                TextField(
                  controller: deskripsiController,
                  decoration: InputDecoration(labelText: 'Deskripsi Barang'),
                ),
                TextField(
                  controller: kategoriController,
                  decoration: InputDecoration(labelText: 'Kategori Barang'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                await firestore_service.addHome(
                  gambarController.text,
                  namaController.text,
                  hargaController.text,
                  deskripsiController.text,
                  kategoriController.text,
                );

                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        decoration: BoxDecoration(
                          color: Color(0xFFF7F8Fa),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Color(0xFFF7F8Fa),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 25, top: 20),
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      'https://shopee.co.id/inspirasi-shopee/wp-content/uploads/2019/11/image-1280x720.png',
                      width: MediaQuery.of(context).size.width / 1.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Row(
                      children: [
                        for (int i = 0; i < catList.length; i++)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = catList[i];
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 18),
                              decoration: BoxDecoration(
                                color: selectedCategory == catList[i]
                                    ? Color(0xFFFD725A)
                                    : Color(0xFFF7F8FA),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Text(
                                catList[i],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: selectedCategory == catList[i]
                                      ? Color(0xFFF7F8FA)
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 340,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirestoreService().getHome(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        } else {
                          List homeListraw = snapshot.data!.docs;
                          List homeList = homeListraw.where((doc) {
                            Map<String, dynamic> data =
                                doc.data() as Map<String, dynamic>;
                            return selectedCategory == "All" ||
                                data['category'] == selectedCategory;
                          }).toList();

                          return SizedBox(
                            width: double.infinity,
                            child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio:
                                      (MediaQuery.of(context).size.width -
                                              30 -
                                              15) /
                                          (2 * 290),
                                  mainAxisSpacing: 45,
                                  crossAxisSpacing: 15,
                                ),
                                itemCount: homeList.length,
                                itemBuilder: (_, i) {
                                  DocumentSnapshot documentSnapshot =
                                      homeList[i];
                                  Map<String, dynamic> data = documentSnapshot
                                      .data() as Map<String, dynamic>;

                                  // Check if the selected category is "All" or matches the category of the product
                                  if (selectedCategory == "All" ||
                                      data['category'] == selectedCategory) {
                                    // Display the product card
                                    return i % 2 == 0
                                        ? ProductCard(
                                            image: data['gambar'],
                                            name: data['namabarang'],
                                            price: data['hargabarang'],
                                            description:
                                                data['deskripsi'] ?? "",
                                            id: documentSnapshot.id,
                                            data: data,
                                          )
                                        : OverflowBox(
                                            maxHeight: 290.0 + 70.0,
                                            child: Container(
                                              margin: EdgeInsets.only(top: 60),
                                              child: ProductCard(
                                                image: data['gambar'],
                                                name: data['namabarang'],
                                                price: data['hargabarang'],
                                                description:
                                                    data['deskripsi'] ?? "",
                                                id: documentSnapshot.id,
                                                data: data,
                                              ),
                                            ),
                                          );
                                  } else {
                                    // Return an empty container if the category doesn't match
                                    return Container();
                                  }
                                }),
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        iconSize: 25,
        selectedItemColor: Color(0xFFFD725A),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            // Indeks 3 adalah indeks ikon orang pada BottomNavigationBar
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePic()),
            );
          }
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}
