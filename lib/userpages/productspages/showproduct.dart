import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahoolar_bazar/cart/cart_page.dart';
import 'package:sahoolar_bazar/userpages/productspages/detailproductpage.dart';

go(Widget func, BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => func));
}

class ShowProductPage extends StatefulWidget {
  String title;
  ShowProductPage({this.title});

  @override
  State<ShowProductPage> createState() => _ShowProductPageState();
}

class _ShowProductPageState extends State<ShowProductPage> {
  String search;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(CartPage());
              },
              icon: Icon(Icons.add_shopping_cart))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  search = value.toLowerCase();
                });
                print(search);
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: "Search for Items",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.blue,
                  )),
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder(
                stream: (search != "" && search != null)
                    ? FirebaseFirestore.instance
                        .collection('products')
                        .where("namesearch".toLowerCase(),
                            arrayContains: search.toLowerCase())
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('products')
                        .where("Product catagory", isEqualTo: widget.title)
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

                  return Container(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            go(
                                DetailProductPage(
                                  image: data[index]['image '],
                                  title: data[index]['name'],
                                  description: data[index]['description'],
                                  price: data[index]['Price'],
                                  category: data[index]['Product catagory'],
                                  serialcode: data[index]['Serial Code'],
                                  weight: data[index]['weight'],
                                  //popular: data[index]['name'],
                                  // title: data[index]['name'],
                                ),
                                context);
                            // Navigator.push(
                            //     context, MaterialPageRoute(builder: (_)=>));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 3,
                                    spreadRadius: 3,
                                    offset: Offset(3, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      data[index]['image '],
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: Text(
                                      data[index]['name'],
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
