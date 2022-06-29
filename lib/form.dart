import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class FormPage extends StatefulWidget {
  //constructor have one parameter, optional paramter
  //if have id we will show data and run update method
  //else run add data
  const FormPage({this.id});

  final String? id;

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  //set form key
  final _formKey = GlobalKey<FormState>();

  //set texteditingcontroller variable
  var nameController = TextEditingController();
  var kodeController = TextEditingController();
  var namabarangController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var addressController = TextEditingController();

  //inisialize firebase instance
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  CollectionReference? penitip;

  void getData() async {
    //get users collection from firebase
    //collection is table in mysql
    penitip = firebase.collection('penitip');

    //if have id
    if (widget.id != null) {
      //get users data based on id document
      var data = await penitip!.doc(widget.id).get();

      //we get data.data()
      //so that it can be accessed, we make as a map
      var item = data.data() as Map<String, dynamic>;

      //set state to fill data controller from data firebase
      setState(() {
        nameController = TextEditingController(text: item['name']);
        kodeController = TextEditingController(text: item['kode']);
        namabarangController = TextEditingController(text: item['namabarang']);
        phoneNumberController =
            TextEditingController(text: item['phoneNumber']);
        addressController = TextEditingController(text: item['address']);
      });
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Data Barang"),
          actions: [
            //if have data show delete button
            widget.id != null
                ? IconButton(
                    onPressed: () async {
                      //method to delete data based on id
                      await penitip!.doc(widget.id).delete();

                      //back to main page
                      // '/' is home
                      // Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                      Navigator.of(context).pop(true);
                    },
                    icon: Icon(Icons.delete))
                : SizedBox()
          ],
        ),
        //this form for add and edit data
        //if have id passed from main, field will show data
        body: Form(
          key: _formKey,
          child: ListView(padding: EdgeInsets.all(16.0), children: [
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: 30,
              child: Icon(
                Icons.person,
                size: 30,
              ),
            ),
            Text(
              'Kode Barang',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: kodeController,
              decoration: InputDecoration(
                  hintText: "Kode Barang",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Kode Barang is Required!';
                }
                return null;
              },
            ),
            Text(
              'Nama Barang',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: namabarangController,
              decoration: InputDecoration(
                  hintText: "Nama Barang",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Nama Barang is Required!';
                }
                return null;
              },
            ),
            Text(
              'Nama Pemilik',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: "Nama Pemilik",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Name is Required!';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Text(
              'No.Hp',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                  hintText: "No.Hp",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'No.Hp is Required!';
                }
                return null;
              },
            ),
            Text(
              'Alamat',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: addressController,
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: null,
              decoration: InputDecoration(
                  hintText: "Alamat",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Alamat is Required!';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  //if id not null run add data to store data into firebase
                  //else update data based on id
                  if (widget.id == null) {
                    penitip!.add({
                      'name': nameController.text,
                      'kode': kodeController.text,
                      'namabarang': namabarangController.text,
                      'phoneNumber': phoneNumberController.text,
                      'address': addressController.text
                    });
                  } else {
                    penitip!.doc(widget.id).update({
                      'name': nameController.text,
                      'kode': kodeController.text,
                      'namabarang': namabarangController.text,
                      'phoneNumber': phoneNumberController.text,
                      'address': addressController.text
                    });
                  }
                  //snackbar notification
                  final snackBar =
                      SnackBar(content: Text('Data saved successfully!'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  //back to main page
                  //home page => '/'
                  // Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                  Navigator.of(context).pop(true);
                }
              },
            )
          ]),
        ));
  }
}
