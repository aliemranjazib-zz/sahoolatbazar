import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sahoolar_bazar/adminside/adminlogin.dart';
import 'package:sahoolar_bazar/components/progressbar.dart';
import 'package:sahoolar_bazar/constants/constants.dart';
import 'package:sahoolar_bazar/userpages/homepage..dart';
import 'package:sahoolar_bazar/userpages/signup.dart';

class LoginScreen extends StatelessWidget {
//  static final id = '/login';
  var globalKey = GlobalKey<FormState>();
  TextEditingController eC = TextEditingController();
  TextEditingController pC = TextEditingController();

  saveform(BuildContext context) async {
    if (globalKey.currentState.validate()) {
      showDialog(
          context: context,
          builder: (context) {
            return ProgressBar(
              title: 'loging in please wait...',
            );
          });
      print(eC.text);
      await auth
          .signInWithEmailAndPassword(email: eC.text.trim(), password: pC.text)
          .catchError((errmsg) {
        Fluttertoast.showToast(msg: errmsg.toString());
      });
      var u = auth.currentUser.uid;
      if (u != null) {
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (_) => HomepPage()), (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 481,
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('asset/ws.png'),
                )),
                Expanded(
                  flex: 2,
                  child: Form(
                      key: globalKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: eC,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                //color: Colors.white,
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
                                  hintText: 'enter email',
                                  prefixIcon: Icon(
                                    Icons.email,
                                  ),
                                  border: OutlineInputBorder()),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              obscureText: true,
                              controller: pC,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
                                  hintText: 'enter password',
                                  prefixIcon: Icon(
                                    Icons.lock,
                                  ),
                                  border: OutlineInputBorder()),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () {
                                saveform(context);
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => AdminLogin()));
                                },
                                child: Text('I AM ADMIN',
                                    style: TextStyle(
                                      fontSize: 19,
                                      textBaseline: TextBaseline.alphabetic,
                                      fontWeight: FontWeight.bold,
                                    )))
                          ],
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
