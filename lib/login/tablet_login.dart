import 'package:creative/constants.dart';
import 'package:flutter/material.dart';

import '../services/functions/authFunction.dart';
import '../util/my_box.dart';
import '../util/my_tail.dart';

class TabletLogin extends StatefulWidget {
  const TabletLogin({super.key});

  @override
  State<TabletLogin> createState() => _TabletLoginState();
}

class _TabletLoginState extends State<TabletLogin> {
  final _formkey = GlobalKey<FormState>();

  String email = '', password = '', fullname = '';
  bool login = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            login
                ? Container()
                : TextFormField(
                    key: ValueKey('fullname'),
                    decoration: InputDecoration(hintText: 'Enter Full Name'),
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
            TextFormField(
                key: ValueKey('email'),
                decoration: InputDecoration(hintText: 'Enter E-mail Id'),
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
            TextFormField(
                key: ValueKey('password'),
                obscureText: true,
                decoration: InputDecoration(hintText: 'Enter Password'),
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
            Container(
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      login
                          ? AuthServices.signinUser(email, password, context)
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
                child: Text(login
                    ? "Don't have an account? Signup"
                    : "Already have an account? Login"))
          ]),
        ),
      ),
    );
  }
}
