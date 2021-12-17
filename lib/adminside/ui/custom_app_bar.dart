import 'package:flutter/material.dart';
import 'package:sahoolar_bazar/adminside/adminlogin.dart';
import 'package:sahoolar_bazar/constants/constants.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0.0,
      // leading: IconButton(
      //   icon: const Icon(Icons.menu),
      //   iconSize: 28.0,
      //   onPressed: () {},
      // ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.logout),
          iconSize: 28.0,
          onPressed: () {
            auth.signOut().whenComplete(() => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (c) => AdminLoginPage()),
                (route) => false));
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
