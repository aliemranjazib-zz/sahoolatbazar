import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahoolar_bazar/about.dart';
import 'package:sahoolar_bazar/adminside/adminmainpage.dart';
import 'package:sahoolar_bazar/cart/cart_page.dart';
import 'package:sahoolar_bazar/constants/constants.dart';
import 'package:sahoolar_bazar/terms/terms.dart';
import 'package:sahoolar_bazar/userpages/auth/logi_page.dart';
import 'package:sahoolar_bazar/userpages/homepage.dart';
import 'package:sahoolar_bazar/userpages/productspages/showproduct.dart';
import 'package:sahoolar_bazar/utils/styles.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String name = "";
  String email = "";
  getcart() {
    var u = auth.currentUser.uid;
    print(u);
    Stream<QuerySnapshot> productRef = FirebaseFirestore.instance
        .collection("user")
        .where("uid", isEqualTo: u)
        .snapshots();
    productRef.forEach((field) {
      field.docs.asMap().forEach((index, data) {
        setState(() {
          name = field.docs[index]["name"];
          email = field.docs[index]["email"];
          // mm.addAll({
          //   name: ,
          //   'images': field.docs[index]["image"],

          // });
          print("okk $name");
          // productName = productName + field.docs[index]["title"];
          // images = field.docs[index]["image"];
        });
      });
    });
  }

  @override
  void initState() {
    // getcart();
    super.initState();
  }

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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              child: Icon(
                                Icons.person,
                                size: 50,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                "$name",
                                style: h1,
                              ),
                            ),
                          ],
                        ),
                        Text("$email")
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

            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => TermsPage()));
              },
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text('Terms and Condition'),
              ),
            ),
            Divider(),
            ListTile(
              leading: Text(""),
              title: Text('Version 1.0'),
            ),
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
