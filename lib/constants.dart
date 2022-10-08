import 'package:creative/services/functions/authFunction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

FirebaseAuth auth = FirebaseAuth.instance;

signOut() async {
  await FirebaseAuth.instance.signOut();
}

var defaultBackgroundColor = Color.fromRGBO(13, 15, 27, 1);
var appBarColor = const Color.fromRGBO(32, 21, 54, 1);
var myAppBar = AppBar(
  backgroundColor: appBarColor,
  title: Text(' '),
  centerTitle: false,
);
var drawerTextColor = TextStyle(
  color: Colors.white,
);
var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);
var myDrawer = Drawer(
  backgroundColor: const Color.fromRGBO(107, 86, 139, 1),
  elevation: 0,
  child: Column(
    children: [
      Center(
        // padding: tilePadding,
        child: ListTile(
          title: Text(
            'Hi Asang Borkar',
            style: drawerTextColor,
          ),
        ),
      ),
      DrawerHeader(
        child: Icon(
          Icons.favorite,
          color: const Color.fromRGBO(13, 15, 27, 1),
          size: 64,
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.home),
          title: Text(
            'D A S H B O A R D',
            style: drawerTextColor,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.settings),
          title: Text(
            'S E T T I N G S',
            style: drawerTextColor,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.info),
          title: Text(
            'A B O U T',
            style: drawerTextColor,
          ),
        ),
      ),
      TextButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
        },
        child: TextButton(
          onPressed: signOut,
          child: Padding(
            padding: tilePadding,
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'L O G O U T',
                style: drawerTextColor,
              ),
            ),
          ),
        ),
      ),
    ],
  ),
);
