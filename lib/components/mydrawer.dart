import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahoolar_bazar/about.dart';
import 'package:sahoolar_bazar/adminside/adminmainpage.dart';
import 'package:sahoolar_bazar/cart/cart_page.dart';
import 'package:sahoolar_bazar/constants/constants.dart';
import 'package:sahoolar_bazar/userpages/auth/logi_page.dart';
import 'package:sahoolar_bazar/userpages/homepage.dart';
import 'package:sahoolar_bazar/userpages/productspages/showproduct.dart';
import 'package:sahoolar_bazar/utils/styles.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      child: Drawer(
        child: Column(
          children: [
            DrawerHeader(
                padding: EdgeInsets.all(0.0),
                child: Container(
                  width: double.infinity,
                  color: Colors.grey.withOpacity(0.2),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "GUEST",
                          style: h1,
                        ),
                      ],
                    ),
                  )),
                )),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => HomePage()));
              },
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     Get.to(ShowProductPage());
            //   },
            //   child: ListTile(
            //     leading: Icon(Icons.shop),
            //     title: Text('Products'),
            //   ),
            // ),
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //         context, MaterialPageRoute(builder: (_) => AdminPage()));
            //   },
            //   child: ListTile(
            //     leading: Icon(Icons.admin_panel_settings_rounded),
            //     title: Text('ADMIN'),
            //   ),
            // ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => CartPage()));
              },
              child: ListTile(
                leading: Icon(Icons.production_quantity_limits),
                title: Text('My Orders'),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AboutPage()));
              },
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text('About'),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                auth.signOut().whenComplete(() => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (c) => LoginPage()),
                    (route) => false));
              },
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logut'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
