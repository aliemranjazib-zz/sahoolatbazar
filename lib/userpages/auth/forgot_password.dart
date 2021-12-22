import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController search = TextEditingController();
  var fkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text('Reset',
                      style: TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 155.0, 0.0, 0.0),
                  child: Text('Password',
                      style: TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(215.0, 155.0, 0.0, 0.0),
                  child: Text('?',
                      style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Enter the email address associated with your account.',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                ),
                Form(
                  key: fkey,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        value = search.text;
                      });
                    },
                    controller: search,
                    validator: (input) =>
                        input.isValidEmail() ? null : "Check your email",
                    decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                ),
                SizedBox(height: 40.0),
                Container(
                  height: 40.0,
                  child: MaterialButton(
                    onPressed: () {
                      if (fkey.currentState.validate()) {
                        FirebaseAuth fb = FirebaseAuth.instance;
                        fb.sendPasswordResetEmail(email: search.text).then(
                            (value) => Fluttertoast.showToast(
                                msg: "Check your email"));
                      }
                    },
                    color: Colors.blue,
                    elevation: 7.0,
                    child: Center(
                        child: Text(
                      'RESET PASSWORD',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // InkWell(
              //   onTap: () {
              //        Navigator.push(
              //         context,
              //         new MaterialPageRoute(
              //           builder: (BuildContext context) =>
              //               new ResetPasswordMobilePage(title: 'Reset Password : Mobile'),
              //         ));
              //   },
              //   child: Text('Try another way ?',
              //       style: TextStyle(
              //           color: Colors.blue,
              //           fontWeight: FontWeight.bold,
              //           decoration: TextDecoration.underline)),
              // )
            ],
          )
        ],
      ),
    );
  }
}


// class ForgotPassword extends StatefulWidget {
//   @override
//   State<ForgotPassword> createState() => _ForgotPasswordState();
// }

// class _ForgotPasswordState extends State<ForgotPassword> {
//   String email;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Forget your password?"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(14.0),
//         child: Column(
//           children: [
//             SizedBox(height: 30),
//             Text(
//               "FORGET PASSWORD?",
//               style: TextStyle(
//                 fontSize: 27,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text("Enter your email address to get password"),
//             SizedBox(height: 30),
//             TextFormField(
//               validator: (v) {
//                 if (v.isEmpty && !v.contains("@")) {
//                   return "please enter correct email";
//                 }
//                 return null;
//               },
//               onChanged: (value) {
//                 setState(() {
//                   email = value.toLowerCase();
//                 });
//               },
//               decoration: InputDecoration(
//                   contentPadding: EdgeInsets.all(10),
//                   hintText: "Search for Items",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30)),
//                   prefixIcon: Icon(
//                     Icons.search,
//                     color: Colors.blue,
//                   )),
//             ),
//             SizedBox(height: 30),
//             MaterialButton(
//                 minWidth: double.infinity,
//                 shape: StadiumBorder(),
//                 onPressed: () {
//                   // Get.to(CheckOutPage());
                
//                 },
//                 color: Colors.blue,
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Text(
//                     "Send me a link",
//                     style: TextStyle(
//                       fontSize: 17,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }
