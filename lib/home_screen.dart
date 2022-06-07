import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:uts/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
          child: Column(
        children: [
          Text('Selamat Datang',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
          Text('Aplikasi Penitipan Barang',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
          SizedBox(height: 450),
          ElevatedButton(
            onPressed: () {
              var box = Hive.box('userBox').clear();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text('Logout'),
          ),
        ],
      )),
    );
  }
}
