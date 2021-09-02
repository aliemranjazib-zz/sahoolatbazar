import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sahoolar_bazar/userpages/mainpage.dart';

class SpalshScreen extends StatefulWidget {
  @override
  _SpalshScreenState createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => MainPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Image.asset('aseets/logo.jpg')),
          Expanded(child: Center(child: CircularProgressIndicator())),
        ],
      ),
    );
  }
}
