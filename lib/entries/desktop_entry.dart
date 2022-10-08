import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import 'package:creative/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'item_model.dart';
//import 'package:image_picker/image_picker.dart';

class DesktopEntries extends StatefulWidget {
  const DesktopEntries({super.key});

  @override
  State<DesktopEntries> createState() => _DesktopEntriesState();
}

class _DesktopEntriesState extends State<DesktopEntries> {
  List<Item> Items = [];
  late File file;
  bool isUploading = false;

  final db = FirebaseFirestore.instance;
  String? name;
  String? category;
  String? url;
  String? downloadUrl;
  Image? image;
  String? val = "";

  fetchRecord() async {
    var records =
        await FirebaseFirestore.instance.collection('Wordpress').get();
    mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _list = records.docs
        .map((item) => Item(
            name: item['name'],
            category: item['category'],
            url: item['url'],
            downloadUrl: item['downloadUrl']))
        .toList();

    setState(() {
      Items = _list;
    });
  }

  void showdialog() {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(20),
          title: Text("Add Wordpress Theme"),
          content: Form(
            key: formkey,

            // autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Enter Name"),
                  // validator: (val) {
                  //   if (val.isEmpty) {
                  //     return "Cant be empty";
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  onChanged: (val) {
                    name = val;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter Category"),
                  // validator: (val) {
                  //   if (val.isEmpty) {
                  //     return "Cant be empty";
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  onChanged: (val) {
                    category = val;
                  },
                ),
                TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter Preview Url"),
                  // validator: (val) {
                  //   if (val.isEmpty) {
                  //     return "Cant be empty";
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  onChanged: (val) {
                    url = val;
                  },
                ),
                TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter Download Link"),
                  // validator: (val) {
                  //   if (val.isEmpty) {
                  //     return "Cant be empty";
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  onChanged: (val) {
                    downloadUrl = val;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  db.collection('Wordpress').add({
                    'name': name,
                    'category': category,
                    'url': url,
                    'downloadUrl': downloadUrl
                  });
                },
                child: const Text('Add'))
          ],
        );
      },
    );
  }

  @override
  void initState() {
    fetchRecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: defaultBackgroundColor,
        floatingActionButton: FloatingActionButton(
          onPressed: showdialog,
          child: const Icon(Icons.add),
        ),
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4),
            itemCount: Items.length,
            itemBuilder: (context, index) {
              if (Items.isEmpty) {
                return ListTile(
                  title: Text(Items[index].name),
                  subtitle: Text(Items[index].category),
                );
                //const CircularProgressIndicator();
              } else {
                return Card(
                  elevation: 50,
                  color: Colors.black,
                  shadowColor: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Image(
                        image: NetworkImage(
                            "https://elements-cover-images-0.imgix.net/04ea21a3-285d-4996-bf53-4df5de093847?auto=compress%2Cformat&fit=max&w=433&s=e87a738402aee9205d5304145968dbfd"),
                        height: 170,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text((Items[index].name)),
                          Text((Items[index].category)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () async {
                                String url = Items[index].url;
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  print('error');
                                }
                              },
                              child: Text(
                                'Preview',
                                style: TextStyle(color: Colors.blueAccent),
                              )),
                          TextButton(
                              onPressed: () async {
                                String url = Items[index].downloadUrl;
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  print('error');
                                }
                              },
                              child: Text(
                                'Download',
                                style: TextStyle(color: Colors.blueAccent),
                              )),
                          TextButton(
                              onPressed: () async {
                                String url = Items[index].downloadUrl;
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  print('error');
                                }
                              },
                              child: Text(
                                'Get License',
                                style: TextStyle(color: Colors.blueAccent),
                              )),
                        ],
                      ),
                    ],
                  ),
                );
              }
            }));
  }
}
