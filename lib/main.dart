import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sahoolar_bazar/userpages/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.green,
      ),
      home: SpalshScreen(),
    );
  }
}
