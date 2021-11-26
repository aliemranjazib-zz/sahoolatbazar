import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahoolar_bazar/checkout/choeckout_page.dart';
import 'package:sahoolar_bazar/components/mydrawer.dart';
import 'package:sahoolar_bazar/userpages/profile_page.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var totalprice = 0;

  int p = 0;

  CollectionReference db = FirebaseFirestore.instance.collection('cart');

  delete(String id) {
    db.doc(id).delete().then((value) {
      Get.snackbar("success", "successfully deleted");
    });
  }

  sum() async {
    await db.get().then((value) {
      value.docs.forEach((e) {
        print(e['price']);
        setState(() {
          p = e['price'] + p;
        });

        print(p);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sum();
  }

  @override
  Widget build(BuildContext context) {
    // print("kkk ${sum()}");

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Cart",
          style: TextStyle(
            color: Colors.deepOrange,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('cart').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final data = snapshot.data.docs;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(totalprice);
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
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: double.infinity, maxHeight: 150),
                        child: Card(
                          child: Row(
                            children: [
                              Image.network(
                                data[index]['image'],
                                height: 90,
                                width: 90,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data[index]['title'],
                                    style: TextStyle(
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    "${data[index]['quanity']}",
                                    style: TextStyle(
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    "${data[index]['price']}",
                                    style: TextStyle(
                                      fontSize: 25,
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
          Container(
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
                        //Get.to(CheckOutPage());
                        var address;
                        FirebaseFirestore.instance
                            .collection('profile')
                            .get()
                            .then((QuerySnapshot querySnapshot) {
                          querySnapshot.docs.forEach((doc) {
                            print(doc['address']);
                            if (doc['address'] != null) {
                              return Get.to(CheckOutPage());
                            } else {
                              return Get.to(ProfilePage());
                            }
                          });
                        });
                      },
                      color: Colors.red,
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
        ],
      ),
    );
  }
}
