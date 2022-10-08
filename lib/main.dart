import 'package:creative/entries/desktop_entry.dart';
import 'package:creative/login/desktop_login.dart';
import 'package:creative/login/mobile_login.dart';
import 'package:creative/login/responsive_login.dart';
import 'package:creative/login/tablet_login.dart';
import 'package:creative/responsive/desktop_body.dart';
import 'package:creative/responsive/mobile_body.dart';
import 'package:creative/responsive/responsive_layout.dart';
import 'package:creative/responsive/tablet_body.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:flutter/material.dart';
import 'package:creative/entries/desktop_entry.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCUIfK8LWM003BktIGwfyfB5k1U_upBbZ4",
          appId: "1:438572660158:web:dd0473f27ef801081a75ef",
          messagingSenderId: "438572660158",
          projectId: "creative-by-pixeltech"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Creative by PixelTech',
      darkTheme: ThemeData(brightness: Brightness.dark),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => ResponsiveLogin(
            mobileBody: const MobileLogin(),
            tabletBody: const TabletLogin(),
            desktopBody: const DesktopLogin()),
        '/dashboard': (BuildContext context) => ResponsiveLayout(
            mobileBody: const MobileScaffold(),
            tabletBody: const TabletScaffold(),
            desktopBody: const DesktopScaffold()),
        '/entry': (BuildContext context) => const DesktopEntries(),
      },
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ResponsiveLayout(
              mobileBody: const MobileScaffold(),
              tabletBody: const TabletScaffold(),
              desktopBody: const DesktopScaffold());
        } else {
          return ResponsiveLogin(
              mobileBody: const MobileLogin(),
              tabletBody: const TabletLogin(),
              desktopBody: const DesktopLogin());
        }
      }),
    );
  }
}
