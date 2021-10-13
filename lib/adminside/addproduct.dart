import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sahoolar_bazar/adminside/addproduct.dart';
import 'package:sahoolar_bazar/components/progressbar.dart';

class AddProduct extends StatelessWidget {
  TextEditingController pname = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add products'),
        actions: [
          TextButton(
              onPressed: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (_) => HomepPage()));
              },
              child: Text(
                'switch to user',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Text("SIGNIN AS ADMIN"),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Form(
                    child: Column(
                  children: [
                    Expanded(flex: 1, child: Image.asset('asset/logo.jpg')),
                    Expanded(
                      child: TextFormField(
                        controller: pname,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'enter product name',
                            prefixIcon: Icon(Icons.email)),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: quantity,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'enter quantity',
                            prefixIcon: Icon(Icons.lock)),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: price,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'enter price',
                            prefixIcon: Icon(Icons.lock)),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      height: 300,
                      color: Colors.grey.withOpacity(0.5),
                      child: Center(
                        child: InkWell(child: Icon(Icons.add)),
                      ),
                    )),
                    MaterialButton(
                      color: Colors.red,
                      onPressed: () {
                        if (pname.text.isEmpty &&
                            quantity.text.isEmpty &&
                            price.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'could not be empty');
                        } else {
                          ProgressBar(title: 'adding');
                          // FirebaseFirestore firestore = FirebaseFirestore.instance;
                          CollectionReference users =
                              FirebaseFirestore.instance.collection('products');
                          users.add({
                            'name': pname.text,
                            'quanity': quantity.text,
                            'price': price.text,
                          }).then((value) {
                            Fluttertoast.showToast(
                                msg: 'product added successfully');
                          }).catchError((error) {
                            Navigator.pop(context);

                            Fluttertoast.showToast(msg: error.toString());
                          });
                        }
                      },
                      child: Text('ADD DATA'),
                    ),
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
