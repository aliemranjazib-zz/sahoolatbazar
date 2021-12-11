import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sahoolar_bazar/constants/constants.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:sahoolar_bazar/userpages/profile_page.dart';

class CheckOutPage extends StatefulWidget {
  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  CollectionReference db = FirebaseFirestore.instance.collection('cart');
  var globalKey = GlobalKey<FormState>();
  TextEditingController uC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController areaC = TextEditingController();
  TextEditingController addressC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var u = auth.currentUser.uid;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Add Address",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Form(
              key: globalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Shipping Adress',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(.8),
                    ),
                  ),
                  component(Icons.account_circle_outlined, 'Full name...',
                      false, false, uC, (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                  }),
                  component(Icons.phone_android, 'Enter Phone...', false, true,
                      phoneC, (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                  }),
                  component(
                      Icons.location_city, 'Enter City...', false, true, cityC,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                  }),
                  component(Icons.map, 'Enter Area...', false, true, areaC,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                  }),
                  component(Icons.location_city, 'Enter Address...', false,
                      true, addressC, (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                  }),
                  // SizedBox(height: size.width * .3),
                ],
              ),
            ),
          ),
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

                final data = snapshot.data.docs;

                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
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
                            maxWidth: double.infinity, maxHeight: 70),
                        child: Row(
                          children: [
                            Image.network(
                              data[index]['image'],
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index]['title'].toString().toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Quantity",
                                      style: TextStyle(),
                                    ),
                                    SizedBox(width: 10),
                                    Container(
                                      constraints: BoxConstraints(
                                        minWidth: 23,
                                        minHeight: 23,
                                        maxWidth: 23,
                                        maxHeight: 23,
                                      ),
                                      color: Colors.grey.withOpacity(0.3),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Text(
                                            "${data[index]['quanity']}",
                                            style: TextStyle(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 30),
                                    Text(
                                      "Rs. ${data[index]['price']}",
                                      style: TextStyle(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          MaterialButton(
              minWidth: double.infinity,
              shape: StadiumBorder(),
              onPressed: () {
                Future.delayed(Duration(seconds: 3), () {
                  if (globalKey.currentState.validate()) {
                    print(uC.text);
                    print(phoneC.text);
                    print(cityC.text);
                    print(addressC.text);
                    print(areaC.text);
                    CollectionReference db =
                        FirebaseFirestore.instance.collection('checkout');
                    Map m = {};
                    var u = auth.currentUser.uid;
                    Stream<QuerySnapshot> productRef = FirebaseFirestore
                        .instance
                        .collection("cart")
                        .where("uid", isEqualTo: u)
                        .snapshots();
                    productRef.forEach((field) {
                      field.docs.asMap().forEach((index, data) {
                        setState(() {
                          m.addAll({
                            'productName': field.docs[index]["title"],
                            'images': field.docs[index]["image"],
                            'price': field.docs[index]["price"],
                            'quantity': field.docs[index]["quantity"],
                          });

                          // productName = productName + field.docs[index]["title"];
                          // images = field.docs[index]["image"];
                        });
                      });
                    });
                    db.add({
                      'name': uC.text,
                      'phone': phoneC.text,
                      'city': cityC.text,
                      'area': areaC.text,
                      'address': addressC.text,
                      'product': m,
                    }).whenComplete(() {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.SUCCES,
                        animType: AnimType.BOTTOMSLIDE,
                        title: 'Congratulations',
                        desc: 'Your Order Placed Successfully',
                        btnOkOnPress: () {},
                      )..show().then((value) {
                          var u = auth.currentUser.uid;
                          Stream<QuerySnapshot> productRef = FirebaseFirestore
                              .instance
                              .collection("cart")
                              .where("uid", isEqualTo: u)
                              .snapshots();
                          productRef.forEach((field) {
                            field.docs.asMap().forEach((index, data) {
                              setState(() {
                                for (QueryDocumentSnapshot snapshot
                                    in field.docs) {
                                  snapshot.reference.delete();
                                }
                              });

                              print(m);
                            });
                          });
                        });
                    });
                  }
                });
              },
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Place Order",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget component(
    IconData icon,
    String hintText,
    bool isPassword,
    bool isEmail,
    TextEditingController controller,
    Function validation,
  ) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: size.height / 13,
        //width: size.width / 1.25,
        // alignment: Alignment.center,
        //padding: EdgeInsets.only(right: size.width / 30),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          validator: validation,
          controller: controller,
          style: TextStyle(
            color: Colors.black.withOpacity(.9),
          ),
          onChanged: (String v) {
            setState(() {
              v = controller.text;
            });
          },
          obscureText: isPassword,
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.black.withOpacity(.8),
            ),
            border: InputBorder.none,
            hintMaxLines: 1,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 12,
              color: Colors.black.withOpacity(.5),
            ),
          ),
        ),
      ),
    );
  }
}
