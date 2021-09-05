import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomepPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('products');
    List<Color> _alreadyUsedColors = [];

    Color _randomColor() {
      Color newColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0);
      while (_alreadyUsedColors.contains(newColor))
        newColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0);
      _alreadyUsedColors.add(newColor);
      return newColor;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text('home screen'),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20)),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'hinttt',
                            border: InputBorder.none,
                            hintStyle: TextStyle(),
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: Icon(Icons.arrow_drop_down),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text("no item added"),
                      );
                    }
                    return ListView(
                      children: snapshot.data.docs
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: _randomColor(),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 2.0,
                                              spreadRadius: 2,
                                              offset: Offset(0.0, 0.75))
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Column(
                                        children: [
                                          //Text('product name :'),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 30,
                                                child: Text("${e['name']}"
                                                    .substring(0, 1)),
                                              ),
                                              SizedBox(width: 20),
                                              Text(
                                                "${e['name']}".toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 75),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      "${e['price']} PKR",
                                                      style: TextStyle(
                                                        fontSize: 30,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Chip(
                                                      label: Text(e['quanity']),
                                                    ),
                                                  ],
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Container(
                                                    width: 80,
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.3),
                                                            spreadRadius: 5,
                                                            blurRadius: 5,
                                                            offset: Offset(2,
                                                                2), // changes position of shadow
                                                          ),
                                                        ],
                                                        color: Colors.amber,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        20))),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text('shop now',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ))
                          .toList(),
                    );
                  }),
            ),
          ],
        ),
      ),
      //     body: FutureBuilder<DocumentSnapshot>(
      //   future: users.doc().get(),
      //   builder:
      //       (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      //     if (snapshot.hasError) {
      //       return Text("Something went wrong");
      //     }

      //     if (snapshot.hasData && !snapshot.data!.exists) {
      //       return Text("Document does not exist");
      //     }

      //     if (snapshot.connectionState == ConnectionState.done) {
      //       Map<String, dynamic> data =
      //           snapshot.data!.data() as Map<String, dynamic>;
      //       return Text("name: ${data['name']} ${data['quanity']}");
      //     }

      //     return Text("loading");
      //   },
      // )
    );
  }
}
