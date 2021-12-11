import 'package:flutter/material.dart';
import 'package:sahoolar_bazar/adminside/Check_out.dart';
import 'package:sahoolar_bazar/adminside/addcategry.dart';
import 'package:sahoolar_bazar/adminside/addproduct.dart';
import 'package:sahoolar_bazar/adminside/addproducts/showmaincaetgory.dart';
import 'package:sahoolar_bazar/adminside/adminlogin.dart';
import 'package:sahoolar_bazar/adminside/update/category%20update/maincategory.dart';
import 'package:sahoolar_bazar/adminside/update/maincategory.dart';
import 'package:sahoolar_bazar/adminside/update/update_sub_category.dart';
import 'package:sahoolar_bazar/components/mydrawer.dart';
import 'package:sahoolar_bazar/constants/constants.dart';

import 'delete/maincategory.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('ADMIN AREA'),
        elevation: 0.0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().whenComplete(() => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (c) => AdminLoginPage()),
                  (route) => false));
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 12, mainAxisSpacing: 10, crossAxisCount: 2),
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Addcategroies()));
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  boxShadow: [],
                ),
                child: Center(
                    child: Text(
                  'ADD SUB CATEGORY',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ShowAdminMainCategoryPage()));
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(color: Colors.amber, boxShadow: []),
                child: Center(
                    child: Text(
                  'ADD PRODUCT',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => MainCategory()));
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  boxShadow: [],
                ),
                child: Center(
                    child: Text(
                  'UPDATE SUB CATEGORY',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Checkout(),
                  ),
                );
              },
              child: Container(
                height: 200,
                width: 200,
                color: Colors.red,
                child: Center(child: Text("Check Out")),
              ),
            ),
            // / InkWell(
            //   onTap: () {
            //     Navigator.of(context)
            //         .push(MaterialPageRoute(builder: (_) => AddProduct()));
            //   },
            //   child: Container(
            //     width: 200,
            //     height: 200,
            //     decoration: BoxDecoration(color: Colors.amber, boxShadow: []),
            //     child: Center(
            //         child: Text(
            //       'ADD PRODUCT',
            //       style: TextStyle(color: Colors.black, fontSize: 20),
            //     )),
            //   ),
            // ),

            // InkWell(
            //   onTap: () {
            //     Navigator.of(context)
            //         .push(MaterialPageRoute(builder: (_) => AddProduct()));
            //   },
            //   child: Container(
            //     width: 200,
            //     height: 200,
            //     decoration: BoxDecoration(color: Colors.amber, boxShadow: []),
            //     child: Center(
            //         child: Text(
            //       'ADD PRODUCT',
            //       style: TextStyle(color: Colors.black, fontSize: 20),
            //     )),
            //   ),
            // ),

            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => MainProductCategory()));
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(color: Colors.amber, boxShadow: []),
                child: Center(
                    child: Text(
                  'Update Category',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => MainCategoryDelete()));
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(color: Colors.amber, boxShadow: []),
                child: Center(
                    child: Text(
                  'Delete Sub Category Product',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
