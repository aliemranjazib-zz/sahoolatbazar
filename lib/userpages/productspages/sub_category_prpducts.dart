import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahoolar_bazar/components/mydrawer.dart';
import 'package:sahoolar_bazar/utils/styles.dart';

class SubCategoryProducts extends StatefulWidget {
  String title;
  SubCategoryProducts({this.title});

  @override
  State<SubCategoryProducts> createState() => _SubCategoryProductsState();
}

class _SubCategoryProductsState extends State<SubCategoryProducts> {
  String search;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.deepOrange),
          title: Text(
            'Category',
            style: TextStyle(color: Colors.black),
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.shop))],
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                  print(search);
                },
                decoration: InputDecoration(
                    hintText: "Search for Items",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.deepOrange,
                    )),
              ),
              SizedBox(height: 20),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        "${widget.title}",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              Expanded(
                child: StreamBuilder(
                  stream: (search != "" && search != null)
                      ? FirebaseFirestore.instance
                          .collection("category")
                          .where("namesearch", arrayContains: search)
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection("category")
                          .where("category", isEqualTo: widget.title)
                          .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (!snapshot.hasData) {
                      return Text("Document does not exist");
                    }
                    return Container(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 3,
                          mainAxisSpacing: 15,
                        ),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          final data = snapshot.data.docs[index];

                          return Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  data['image '],
                                  height: 140,
                                  width: 140,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              Expanded(
                                child: Text(
                                  data['title'],
                                  style: h1,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
