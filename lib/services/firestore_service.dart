import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference home =
      FirebaseFirestore.instance.collection("home");

  Stream<QuerySnapshot> getHome() {
    return home.snapshots();
  }
  
  Future<void> addHome(
      String gambar, String namabarang, String hargabarang, String deskripsi, String kategori) async {
    await home.add({
      "gambar": gambar,
      "namabarang": namabarang,
      "hargabarang": hargabarang,
      "deskripsi": deskripsi,
      "category": kategori,
    });
  }

  Future<void> updateHome(String id, String gambar, String namabarang,
      String hargabarang, String deskripsi, String kategori) async {
    await home.doc(id).update({
     "gambar": gambar,
      "namabarang": namabarang,
      "hargabarang": hargabarang,
      "deskripsi": deskripsi,
      "category": kategori,
    });
  }

  Future<void> deleteHome(String id) async {
    await home.doc(id).delete();
  }
}

