import 'package:creative/login/desktop_login.dart';
import 'package:creative/login/mobile_login.dart';
import 'package:creative/login/responsive_login.dart';
import 'package:creative/login/tablet_login.dart';
import 'package:creative/responsive/mobile_body.dart';
import 'package:creative/services/functions/firebaseFunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../responsive/desktop_body.dart';
import '../../responsive/responsive_layout.dart';
import '../../responsive/tablet_body.dart';

import 'package:creative/responsive/desktop_body.dart';
import 'package:creative/responsive/mobile_body.dart';
import 'package:creative/responsive/responsive_layout.dart';
//import 'firebase';

class AuthServices {
  static signupUser(
      String email, String password, String name, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      await FirestoreServices.saveUser(name, email, userCredential.user!.uid);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Registration Successful')));

      return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResponsiveLayout(
                  desktopBody: DesktopScaffold(),
                  mobileBody: MobileScaffold(),
                  tabletBody: TabletScaffold(),
                )),
      );

      //     Navigator.push<void>(
      //   context,
      //   MaterialPageRoute<void>(
      //     builder: (BuildContext context) => ResponsiveLayout(
      //         mobileBody: const MobileScaffold(),
      //         tabletBody: const TabletScaffold(),
      //         desktopBody: const DesktopScaffold()),
      //   ),
      // );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password Provided is too weak')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Email Provided already Exists')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  static signinUser(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => ResponsiveLayout(
          //             desktopBody: DesktopScaffold(),
          //             mobileBody: MobileScaffold(),
          //             tabletBody: TabletScaffold(),
          //           )),
          // );
          //() =>
          Navigator.of(context).popAndPushNamed('/dashboard');
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('You are Logged in')));
      //return Navigator.of(context).popAndPushNamed('/dashboard');

      //     Navigator.push<void>(
      //   context,
      //   MaterialPageRoute<void>(
      //     builder: (BuildContext context) => ResponsiveLayout(
      //         mobileBody: const MobileScaffold(),
      //         tabletBody: const TabletScaffold(),
      //         desktopBody: const DesktopScaffold()),
      //   ),
      // );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user Found with this Email')));
        return Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResponsiveLogin(
                    desktopBody: DesktopLogin(),
                    mobileBody: MobileLogin(),
                    tabletBody: TabletLogin(),
                  )),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Password did not match')));
        return Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResponsiveLogin(
                    desktopBody: DesktopLogin(),
                    mobileBody: MobileLogin(),
                    tabletBody: TabletLogin(),
                  )),
        );
      }
    }
  }

  static signout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    return Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ResponsiveLogin(
                desktopBody: DesktopLogin(),
                mobileBody: MobileLogin(),
                tabletBody: TabletLogin(),
              )),
    );
  }
}
