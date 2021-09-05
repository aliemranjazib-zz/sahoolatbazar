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
    Timer(Duration(seconds: 4), () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => MainPage()));
    });
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
          Expanded(child: Center(child: CircularProgressIndicator())),
        ],
      ),
    );
  }
}
