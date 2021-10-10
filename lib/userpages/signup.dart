import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sahoolar_bazar/adminside/adminlogin.dart';
import 'package:sahoolar_bazar/components/progressbar.dart';
import 'package:sahoolar_bazar/constants/constants.dart';
import 'package:sahoolar_bazar/userpages/homepage..dart';
import 'package:sahoolar_bazar/userpages/login.dart';

class SignUpScreen extends StatelessWidget {
  var globalKey = GlobalKey<FormState>();
  TextEditingController fC = TextEditingController();
  TextEditingController lC = TextEditingController();

  TextEditingController eC = TextEditingController();
  TextEditingController pC = TextEditingController();
  // static final id = '/signup';
  saveform(BuildContext context) async {
    if (globalKey.currentState.validate()) {
      print(eC.text);
      showDialog(
          context: context,
          builder: (context) {
            return ProgressBar(
              title: 'signing up please wait...',
            );
          });
      await auth
          .createUserWithEmailAndPassword(
              email: eC.text.trim(), password: pC.text)
          .catchError((errmsg) {
        Fluttertoast.showToast(msg: errmsg);
      });
      Map userMap = {'name': fC.text, 'email': eC.text, 'password': pC.text};
      var u = auth.currentUser.uid;
      if (u != null) {
        // Navigator.push(context, MaterialPageRoute(builder: (c) => HomepPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 675,
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('asset/logo.jpg'),
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
                                controller: fC,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  //color: Colors.white,
                                  fontSize: 20,
                                ),
                                decoration: InputDecoration(
                                    hintText: 'enter first name',
                                    prefixIcon: Icon(
                                      Icons.person,
                                    ),
                                    border: OutlineInputBorder()),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: lC,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                decoration: InputDecoration(
                                    hintText: 'enter last name',
                                    prefixIcon: Icon(
                                      Icons.person,
                                    ),
                                    border: OutlineInputBorder()),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: eC,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                decoration: InputDecoration(
                                    hintText: 'enter email',
                                    prefixIcon: Icon(
                                      Icons.lock,
                                    ),
                                    border: OutlineInputBorder()),
                              ),
                              SizedBox(height: 20),
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
                              SizedBox(height: 20),
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
      ),
    );
  }
}
