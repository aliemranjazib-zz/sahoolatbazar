import 'package:flutter/material.dart';
import 'package:sahoolar_bazar/adminside/addproduct.dart';
import 'package:sahoolar_bazar/adminside/adminmainpage.dart';
import 'package:sahoolar_bazar/userpages/login.dart';
import 'package:sahoolar_bazar/userpages/mainpage.dart';

class AdminLogin extends StatelessWidget {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: ListView(
              children: [
                Center(child: Text("SIGNIN AS ADMIN")),
                Container(
                  height: 500,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Form(
                        child: Column(
                      children: [
                        Expanded(
                            flex: 3, child: Image.asset('asset/Login.jpg')),
                        Expanded(
                          child: TextFormField(
                            controller: emailC,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'enter email',
                                prefixIcon: Icon(Icons.email)),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: passwordC,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'enter password',
                                prefixIcon: Icon(Icons.lock)),
                          ),
                        ),
                        MaterialButton(
                          color: Colors.blue.shade300,
                          onPressed: () {
                            if (emailC.text == 'admin@gmail.com' &&
                                passwordC.text == "1234") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => AdminPage()));
                            }
                          },
                          child: Text('LOGIN'),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => MainPage()));
                            },
                            child: Text(
                              'I AM USER',
                              style: TextStyle(color: Colors.black),
                            ))
                      ],
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
