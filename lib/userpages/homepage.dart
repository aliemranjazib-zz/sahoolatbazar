import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahoolar_bazar/category/main_category/main_category_model.dart';
import 'package:sahoolar_bazar/components/mydrawer.dart';
import 'package:sahoolar_bazar/constants/constants.dart';
import 'package:sahoolar_bazar/userpages/productspages/detailproductpage.dart';
import 'package:sahoolar_bazar/userpages/productspages/showproduct.dart';
import 'package:sahoolar_bazar/userpages/productspages/sub_category_prpducts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sahoolar_bazar/utils/styles.dart';

class HomePage extends StatefulWidget {
  static const id = 'homepage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var search = TextEditingController();
  List<String> productImages = [];
  checksum() {
    var u = auth.currentUser.uid;
    Future.delayed(Duration(seconds: 1), () {
      Stream<QuerySnapshot> productRef = FirebaseFirestore.instance
          .collection("products")
          .where("Popular", isEqualTo: true)
          .snapshots();
      productRef.forEach((field) {
        field.docs.asMap().forEach((index, data) {
          setState(() {
            // p = p + field.docs[index]["price"];
            //print(field.docs[index]["image "]);
            productImages.add(field.docs[index]["image "]);
          });

          print(productImages);
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // sum();
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 4), () {
    //   checksum();
    // });
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: Text('HOME PAGE', style: TextStyle(color: Colors.white)),
          toolbarHeight: 80,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.vertical(
              bottom: new Radius.elliptical(12, 12.0),
            ),
          ),
        ),
        drawer: MyDrawer(),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                    child: Text(
                      "Popular Products",
                      style: h1,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('products')
                        .where("Popular", isEqualTo: true)
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
                      // for (var i = 0; i < data.length; i++) {
                      //   if (productImages.length > 0) {
                      //     productImages.add(data[i]['image ']);
                      //   } else {
                      //     return Center(child: CircularProgressIndicator());
                      //   }
                      // }

                      return Container(
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 200,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            // onPageChanged: callbackFunction,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: data.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return InkWell(
                                  onTap: () {
                                    go(
                                        DetailProductPage(
                                          image: i['image '],
                                          title: i['name'],
                                          description: i['description'],
                                          price: i['Price'],
                                          category: i['Product catagory'],
                                          serialcode: i['Serial Code'],
                                          weight: i['weight'],
                                          //popular: data[index]['name'],
                                          // title: data[index]['name'],
                                        ),
                                        context);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    //margin: EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      // gradient: LinearGradient(
                                      //     begin: Alignment.centerLeft,
                                      //     end: Alignment.centerRight,
                                      //     colors: [Colors.purple, Colors.blue]),
                                    ),
                                    child: Container(
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: Image.network(
                                              i['image '],
                                              fit: BoxFit.contain,
                                              height: 200,
                                              width: 200,
                                            ),
                                          ),
                                          Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    i['name'],
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          // Container(
                                          //     color: Colors.black.withOpacity(0.6)),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                  Divider(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: maincategorydata
                        .map((e) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SubCategoryProducts(
                                                title: e.name,
                                              )));
                                },
                                child: Container(
                                    height: 120,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        gradient: LinearGradient(colors: [
                                          Colors.green.shade200,
                                          Colors.blue.shade300,
                                        ])),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              e.image,
                                              width: 90,
                                              height: 90,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Center(
                                                      child: Text(
                                                        e.name,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Center(
                                                      child: Text(
                                                        e.name,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white54,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              )),
        ));
  }
}
