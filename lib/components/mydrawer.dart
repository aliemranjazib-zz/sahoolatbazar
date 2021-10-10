import 'package:flutter/material.dart';
import 'package:sahoolar_bazar/adminside/adminmainpage.dart';
import 'package:sahoolar_bazar/constants/constants.dart';
import 'package:sahoolar_bazar/userpages/auth/logi_page.dart';
import 'package:sahoolar_bazar/userpages/homepage.dart';
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
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AdminPage()));
              },
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text('ADMIN'),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                auth.signOut().whenComplete(() => Navigator.push(
                    context, MaterialPageRoute(builder: (c) => LoginPage())));
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
