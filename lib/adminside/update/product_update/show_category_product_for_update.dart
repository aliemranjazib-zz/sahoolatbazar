import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sahoolar_bazar/adminside/update/product_update/show_product_for_update.dart';
import 'package:sahoolar_bazar/adminside/update/product_update/update_product.dart';
import 'package:sahoolar_bazar/utils/styles.dart';

class ShowCategoryProductForUpdate extends StatelessWidget {
  String title;
  ShowCategoryProductForUpdate({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('select category product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("category")
                    .where("category", isEqualTo: title)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }

                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
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

                        return Container(
                          // decoration: BoxDecoration(
                          //   boxShadow: [
                          //     BoxShadow(
                          //         color: Colors.grey.withOpacity(0.2),
                          //         blurRadius: 5,
                          //         spreadRadius: 5,
                          //         offset: Offset(3, 3)),
                          //   ],
                          // ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => ShowProductPageForUpdate(
                                          title: data['title'])));
                            },
                            child: Column(
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
                                Expanded(
                                  child: Text(
                                    data['title'],
                                    textAlign: TextAlign.center,
                                    style: h1,
                                  ),
                                ),
                              ],
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
