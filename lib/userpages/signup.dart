import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sahoolar_bazar/userpages/homepage..dart';

class SignupPage extends StatelessWidget {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.blue,
          Colors.green,
        ])),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
              child: Column(
            children: [
              Expanded(flex: 2, child: Text("SIGNUP")),
              Expanded(
                child: TextFormField(
                  controller: emailC,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'enter email',
                      prefixIcon: Icon(Icons.email)),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: passwordC,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'enter password',
                      prefixIcon: Icon(Icons.lock)),
                ),
              ),
              MaterialButton(
                color: Colors.red,
                onPressed: () {
                  if (!emailC.text.contains('@') || passwordC.text.length < 7) {
                    Fluttertoast.showToast(msg: 'ivalid data');
                  } else {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    auth.createUserWithEmailAndPassword(
                        email: emailC.text, password: passwordC.text);
                    User? user = auth.currentUser;
                    if (user != null) {
                      // FirebaseFirestore firestore = FirebaseFirestore.instance;
                      CollectionReference users =
                          FirebaseFirestore.instance.collection('users');
                      users.add(
                          {'email': emailC.text, 'password': passwordC.text});
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => HomepPage()));
                    }
                  }
                },
                child: Text('SIGNUP'),
              )
            ],
          )),
        ),
      ),
    );
  }
}
