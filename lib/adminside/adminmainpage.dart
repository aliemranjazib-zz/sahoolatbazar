import 'package:flutter/material.dart';
import 'package:sahoolar_bazar/adminside/addcategry.dart';
import 'package:sahoolar_bazar/adminside/addproduct.dart';
import 'package:sahoolar_bazar/adminside/addproducts/showmaincaetgory.dart';
import 'package:sahoolar_bazar/components/mydrawer.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('ADMIN AREA'),
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
            // Container(
            //   width: 200,
            //   height: 200,
            //   color: Colors.amber,
            //   child: Center(
            //       child: Text(
            //     'ADD PRODUCT',
            //     style: TextStyle(color: Colors.black, fontSize: 20),
            //   )),
            // ),
            // Container(
            //   width: 200,
            //   height: 200,
            //   color: Colors.amber,
            //   child: Center(
            //       child: Text(
            //     'EDIT PRODUCT',
            //     style: TextStyle(color: Colors.black, fontSize: 20),
            //   )),
            // ),
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
          ],
        ),
      ),
    );
  }
}
