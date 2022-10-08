import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? name;
  String? email;

  UserModel({this.id, this.name, this.email});

  // UserModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
  //   id = documentSnapshot.documentID;
  //   name = documentSnapshot["name"];
  //   email = documentSnapshot["email"];
  // }
  UserModel.fromData(Map<String, dynamic>? dataMap)
      : id = dataMap!['id'],
        name = dataMap['name'],
        email = dataMap['email'];

  Map<String, dynamic> toData() {
    return {
      'uid': id,
      'name': name,
      'email': email,
    };
  }
}
