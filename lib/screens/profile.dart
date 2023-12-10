import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onlineshop/login.dart';
import 'package:onlineshop/screens/home_screen.dart';
import 'package:onlineshop/widgets/constants.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User? _user;
  String name = "";
  String email = "";
  String telepon = "";

  @override
  void initState() {
    // TODO: implement initState
    _user = _auth.currentUser;
    _loadUserData();
    super.initState();
  }

  Future<void> _loadUserData() async {
    if (_user != null) {
      try {
        DocumentSnapshot userSnapshot =
            await _firestore.collection("profile").doc(_user!.uid).get();
        if (userSnapshot.exists) {
          setState(() {
            name = userSnapshot.get("nama") ?? "";
            email = userSnapshot.get("email") ?? "";
            telepon = userSnapshot.get("telephone") ?? "";
          });
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        iconSize: 25,
        selectedItemColor: Color(0xFFFD725A),
        unselectedItemColor: Colors.grey,
        currentIndex: 1,
        onTap: (index) {
          // Indeks 3 adalah indeks ikon orang pada BottomNavigationBar
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 90,
            ),
            // Profile Picture
            MyFP(),
            // List FP
            ProfileMenu(
              text: name,
              ikon: Icons.person,
              press: () => {},
            ),
            ProfileMenu(
              text: email,
              ikon: Icons.email,
              press: () => {},
            ),
            ProfileMenu(
              text: telepon,
              ikon: Icons.call,
              press: () => {},
            ),
            ProfileMenu(
              text: "Log Out",
              ikon: Icons.logout,
              press: () {
                // Navigate to the login screen when Log Out is pressed
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    this.press,
    required this.ikon,
  }) : super(key: key);

  final String text;
  final IconData ikon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: kPrimaryColor,
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            // Image.asset(
            //   icon,
            //   color: kPrimaryColor,
            //   width: 15,
            // ),
            Icon(ikon),
            SizedBox(width: 10),
            Expanded(child: Text(text)),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}

class MyFP extends StatelessWidget {
  const MyFP({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://miro.medium.com/v2/resize:fit:310/0*ZYDCn6eN0BkmY8V-.")),
        ],
      ),
    );
  }
}
