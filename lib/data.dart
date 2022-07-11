import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app/form.dart';
import 'package:flutter/material.dart';
import 'package:app/header_drawer.dart';
import 'package:app/data.dart';
import 'package:app/profil.dart';
import 'package:app/login.dart';

class DataPage extends StatefulWidget {
  @override
  State<DataPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<DataPage> {
  @override
  Widget build(BuildContext context) {
    //The entry point for accessing a [FirebaseFirestore].
    FirebaseFirestore firebase = FirebaseFirestore.instance;

    //get collection from firebase, collection is table in mysql
    CollectionReference data = firebase.collection('penitip');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Penitipan Barang"),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MyHeaderDrawer(),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Home"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.star),
                title: const Text("Penitipan Barang"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const FormPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text("Profil"),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Fitur masih dalam pengembangan')));
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Pengaturan"),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Fitur masih dalam pengembangan')));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Log out"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        //data to be retrieved in the future
        future: data.get(),
        builder: (_, snapshot) {
          //show if there is data
          if (snapshot.hasData) {
            // we take the document and pass it to a variable
            var alldata = snapshot.data!.docs;

            //if there is data, make list
            return alldata.length != 0
                ? ListView.builder(

                    // displayed as much as the variable data alldata
                    itemCount: alldata.length,

                    //make custom item with list tile.
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Text(alldata[index]['name'], style: TextStyle(fontSize: 20)),
                        subtitle: Text(alldata[index]['kode'], style: TextStyle(fontSize: 16)),
                        trailing: IconButton(
                            onPressed: () async {
                              var hasilDariFormx = await Navigator.push(
                                context,
                                //pass data to edit form
                                MaterialPageRoute(
                                    builder: (context) => FormPage(
                                          id: snapshot.data!.docs[index].id,
                                        )),
                              );
                              if (hasilDariFormx == true) {
                                setState(() {});
                              }
                            },
                            icon: Icon(Icons.arrow_forward_rounded)),
                      );
                    })
                : Center(
                    child: Text(
                      'No Data',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
          } else {
            return Center(child: Text("Loading...."));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var hasilDariForm = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormPage()),
          );
          if (hasilDariForm == true) {
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
