import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/home_screen.dart';
import 'package:myapp/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            'images/gmbr.png',
            width: 250,
            height: 250,
          ),
          Text(
            'Aplikasi Penitipan Barang ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: TextFormField(
              controller: userNameController,
              decoration: InputDecoration(
                label: Text('Username'),
                hintText: 'Masukkan username',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                label: Text('Password'),
                hintText: 'Masukkan password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Fitur dalam pengembangan')));
                    },
                    child: Text('                                                         Forgot Password?'))
              ],
            ),
          ),
          SizedBox(
            width: 200,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                print('username = ${userNameController.text} ');
                if (userNameController.text == 'admin' && passwordController.text == 'admin') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('anda berhasil login'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('username atau password salah'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text('Login'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Or connect using'),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Fitur dalam pengembangan')));
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.blue[400], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'images/f.png',
                          height: 20,
                          width: 20,
                        ),
                        Text('Facebook')
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Fitur dalam pengembangan')));
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.red[400], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'images/g.png',
                            height: 15,
                            width: 20,
                          ),
                          Text('Google')
                        ],
                      )),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Dont have an Account ? ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                FlatButton(
                  textColor: Colors.blueAccent,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 12),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
