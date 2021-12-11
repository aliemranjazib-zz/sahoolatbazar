import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sahoolar_bazar/userpages/auth/logi_page.dart';
import 'package:sahoolar_bazar/userpages/homepage.dart';

class SplashInitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (_, AsyncSnapshot<User> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SpalshScreen();
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return LoginPage();
          }
          if (snapshot.data.email != null) {
            return SpalshScreen();
            // AppUser.set(snapshot.data.phoneNumber);
          }
          if (snapshot.data.uid == null) {
            return Container(
              child: Text(
                'PLEASE LOGIN FIRST',
                style: TextStyle(fontSize: 30),
              ),
            );
          } else
            return SpalshScreen();
        },
      ),
    );
  }
}

class SpalshScreen extends StatefulWidget {
  @override
  _SpalshScreenState createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(HomePage.id);
      // Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Image.asset('asset/logo.jpg'),
              )),
          Expanded(
              child: Center(
            child: CircularProgressIndicator(),
          )),
        ],
      ),
    );
  }
}
