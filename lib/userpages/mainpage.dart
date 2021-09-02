import 'package:flutter/material.dart';
import 'package:sahoolar_bazar/userpages/login.dart';
import 'package:sahoolar_bazar/userpages/signup.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('SAHOOLAT BAZAR'),
          bottom: TabBar(tabs: [
            Tab(
              child: Text('LOGIN'),
            ),
            Tab(
              child: Text('SIGNUP'),
            ),
          ]),
        ),
        body: TabBarView(children: [
          LoginPage(),
          SignupPage(),
        ]),
      ),
    );
  }
}
