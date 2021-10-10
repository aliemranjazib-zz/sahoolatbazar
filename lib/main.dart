import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahoolar_bazar/adminside/addcategry.dart';
import 'package:sahoolar_bazar/adminside/adminmainpage.dart';
import 'package:sahoolar_bazar/userpages/auth/signup_page.dart';
import 'package:sahoolar_bazar/userpages/homepage.dart';
import 'package:sahoolar_bazar/userpages/mainpage.dart';
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
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SignUpPage(),
      ),
    );
  }
}
