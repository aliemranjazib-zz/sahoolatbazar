import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:sahoolar_bazar/checkout/choeckout_page.dart';
import 'package:sahoolar_bazar/components/mydrawer.dart';
import 'package:sahoolar_bazar/constants/constants.dart';
import 'package:sahoolar_bazar/userpages/profile_page.dart';
import 'package:sahoolar_bazar/utils/styles.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var totalprice = 0;

  int p = 0;
  bool v = true;

  CollectionReference db = FirebaseFirestore.instance.collection('cart');

  delete(String id) {
    db.doc(id).delete().then((value) {
      Get.snackbar("success", "successfully deleted");
    });
  }

  // sum() async {
  //   await db.get().then((value) {
  //     value.docs.forEach((e) {
  //       print(e['price']);
  //       setState(() {
  //         p = e['price'] + p;
  //       });

  //       print(p);
  //     });
  //   });
  // }
  checksum() {
    List<String> productName = [];
    var u = auth.currentUser.uid;
    Stream<QuerySnapshot> productRef = FirebaseFirestore.instance
        .collection("cart")
        .where("uid", isEqualTo: u)
        .snapshots();
    productRef.forEach((field) {
      field.docs.asMap().forEach((index, data) {
        setState(() {
          p = p + field.docs[index]["price"];
        });

        print(productName);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // sum();
    checksum();
  }

  @override
  Widget build(BuildContext context) {
    // print("kkk ${sum()}");
    var u = auth.currentUser.uid;

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        toolbarHeight: 60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Text(
          "Cart",
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('cart')
                  .where("uid", isEqualTo: u)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.data.docs.isEmpty) {
                  Future.delayed(
                      Duration(
                        microseconds: 100,
                      ), () {
                    setState(() {
                      v = false;
                    });
                  });

                  return Center(
                      child: Text(
                    "NO CART ITEM FOUND",
                    style: h1,
                  ));
                }
                final data = snapshot.data.docs;

                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (v) {
                        db.doc(data[index].id).delete().then((value) {
                          setState(() {
                            p = p - data[index]['price'];
                          });
                          Get.snackbar("success", "successfully deleted");
                        });
                      },
                      background: Icon(Icons.delete),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  blurRadius: 3,
                                  spreadRadius: 3,
                                  offset: Offset(3, 3),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4)),
                          constraints: BoxConstraints(
                              maxWidth: double.infinity, maxHeight: 120),
                          child: Row(
                            children: [
                              Image.network(
                                data[index]['image'],
                                height: 90,
                                width: 90,
                                fit: BoxFit.cover,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index]['title']
                                        .toString()
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Quantity",
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        constraints: BoxConstraints(
                                          minWidth: 33,
                                          minHeight: 33,
                                          maxWidth: 33,
                                          maxHeight: 33,
                                        ),
                                        color: Colors.grey.withOpacity(0.3),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Text(
                                              "${data[index]['quanity']}",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Rs. ${data[index]['price']}",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Visibility(
            visible: v,
            child: Container(
              height: 130,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    spreadRadius: 6,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal', style: TextStyle(fontSize: 20)),
                        Text("PKR $p",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    MaterialButton(
                        minWidth: double.infinity,
                        shape: StadiumBorder(),
                        onPressed: () {
                          Get.to(CheckOutPage());
                          var address;
                          // FirebaseFirestore.instance
                          //     .collection('profile')
                          //     .get()
                          //     .then((QuerySnapshot querySnapshot) {
                          //   querySnapshot.docs.forEach((doc) {
                          //     print(doc['address']);
                          //     if (doc['address'] != null) {
                          //       return Get.to(CheckOutPage());
                          //     } else {
                          //       return Get.to(ProfilePage());
                          //     }
                          //   });
                          // });
                        },
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "CheckOut Rs. $p",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
