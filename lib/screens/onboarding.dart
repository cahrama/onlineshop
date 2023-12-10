import 'package:flutter/material.dart';
import 'package:onlineshop/login.dart'; // Import halaman login

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gambar di tengah
            Image.network(
              'https://images.bisnis.com/posts/2020/06/11/1251588/belanja-toko-online.jpg', // Ganti dengan URL gambar yang sesuai
              height: 400,
              width: 400,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 5),
            // Judul
            const Text(
              "Belanja Dari Rumah",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            // Deskripsi header
            const Text(
              "Temukan barang yang cocok untuk anda dan lakukan semua #darirumah",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 40),
            // Tombol "Next" untuk pindah ke halaman login
            SizedBox(
              height: 45,
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFD725A)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(), // Pindah ke halaman login
                    ),
                  );
                },
                child: const Text("Next",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
