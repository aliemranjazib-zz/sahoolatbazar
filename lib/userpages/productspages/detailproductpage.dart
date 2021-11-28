import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sahoolar_bazar/cart/cart_page.dart';
import 'package:sahoolar_bazar/components/progressbar.dart';
import 'package:sahoolar_bazar/constants/constants.dart';

class DetailProductPage extends StatefulWidget {
  String title;
  String image;
  bool popular;
  String price;
  String category;
  String serialcode;
  String description;
  String weight;
  DetailProductPage(
      {this.title,
      this.image,
      this.category,
      this.description,
      this.popular,
      this.price,
      this.serialcode,
      this.weight});

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  int total = 1;
  @override
  Widget build(BuildContext context) {
    int newprice = int.parse(widget.price);
    int totalprice = newprice * total;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        toolbarHeight: 60,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(CartPage());
              },
              icon: Icon(Icons.add_shopping_cart))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                constraints: BoxConstraints(minHeight: 100, maxHeight: 250),
                child: Image.network(widget.image)),
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        " RS.${widget.price}",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "DETAIL",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                )),
            Container(
                alignment: Alignment.bottomRight,
                width: double.infinity,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        blurRadius: 5,
                        spreadRadius: 5,
                        offset: Offset(3, 3),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Quantity",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (total > 1) total--;
                                      });
                                    },
                                    icon: Icon(Icons.remove)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("$total"),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        total++;
                                      });
                                    },
                                    icon: Icon(Icons.add)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      MaterialButton(
                          minWidth: double.infinity,
                          shape: StadiumBorder(),
                          onPressed: () async {
                            ProgressBar(title: 'adding');
                            // FirebaseFirestore firestore = FirebaseFirestore.instance;
                            CollectionReference users =
                                FirebaseFirestore.instance.collection('cart');
                            var u = auth.currentUser.uid;
                            users.add({
                              'uid': u,
                              'title': widget.title,
                              'quanity': total,
                              'price': totalprice,
                              'image': widget.image,
                            }).then((value) {
                              Fluttertoast.showToast(
                                  msg: 'product added successfully');
                            }).catchError((error) {
                              Navigator.pop(context);

                              Fluttertoast.showToast(msg: error.toString());
                            });
                          },
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "Add to Cart Rs. $totalprice",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                          ))
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
