import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';
import '../services/functions/authFunction.dart';
import '../util/my_box.dart';
import '../util/my_tail.dart';

class DesktopLogin extends StatefulWidget {
  const DesktopLogin({super.key});

  @override
  State<DesktopLogin> createState() => _DesktopLoginState();
}

class _DesktopLoginState extends State<DesktopLogin> {
  final _formkey = GlobalKey<FormState>();

  String email = '', password = '', fullname = '';
  bool login = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      body: Stack(
        children: [
          Image.asset('assets/bg-gradient.png'),
          Image.asset('assets/bg-gradient-2.png'),
          Form(
            key: _formkey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/Creative_logo.png',
                    width: MediaQuery.of(context).size.width / 3.25,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(17, 19, 34, 1),
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.height / 1.8,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            login ? "Log In" : "Sign Up",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w200),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          login
                              ? Container()
                              : TextFormField(
                                  cursorColor: Colors.greenAccent,
                                  key: const ValueKey('fullname'),
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.greenAccent,
                                            width: 1.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white70, width: 1.0),
                                      ),
                                      hintText: 'Enter Full Name'),
                                  validator: ((value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter FullName';
                                    } else {
                                      return null;
                                    }
                                  }),
                                  onSaved: (value) => {
                                        setState(() {
                                          fullname = value!;
                                        })
                                      }),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              cursorColor: Colors.greenAccent,
                              key: const ValueKey('email'),
                              decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.greenAccent, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white70, width: 1.0),
                                  ),
                                  hintText: 'Enter E-mail Id'),
                              validator: ((value) {
                                if (value!.isEmpty || !value.contains('@')) {
                                  return 'Please Enter E-mail Id';
                                } else {
                                  return null;
                                }
                              }),
                              onSaved: (value) => {
                                    setState(() {
                                      email = value!;
                                    })
                                  }),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              cursorColor: Colors.greenAccent,
                              key: const ValueKey('password'),
                              obscureText: true,
                              decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.greenAccent, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white70, width: 1.0),
                                  ),
                                  hintText: 'Enter Password'),
                              validator: ((value) {
                                if (value!.length < 6) {
                                  return 'Please Enter Password of min length 6';
                                } else {
                                  return null;
                                }
                              }),
                              onSaved: (value) => {
                                    setState(() {
                                      password = value!;
                                    })
                                  }),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(99, 102, 241, 1),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 100, vertical: 20),
                                  // textStyle: TextStyle(
                                  //     fontSize: 18,
                                  //     fontWeight: FontWeight.w600)
                                ),
                                onPressed: () async {
                                  if (_formkey.currentState!.validate()) {
                                    _formkey.currentState!.save();
                                    login
                                        ? AuthServices.signinUser(
                                            email, password, context)
                                        : //email, password, context
                                        AuthServices.signupUser(
                                            email, password, fullname, context);
                                  }
                                },
                                child: Text(login ? 'Login' : 'Signup')),
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  login = !login;
                                });
                              },
                              child: Text(
                                login
                                    ? "Don't have an account? Signup"
                                    : "Already have an account? Login",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200),
                              ))
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
