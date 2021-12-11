import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sahoolar_bazar/adminside/update/update_sub_category.dart';
import 'package:sahoolar_bazar/utils/styles.dart';

class ShowSubCategoryDelete extends StatelessWidget {
  String title;
  ShowSubCategoryDelete({this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final data = snapshot.data.docs[index];

                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (d) {
                          FirebaseFirestore.instance
                              .collection('category')
                              .doc(data.id)
                              .delete();
                        },
                        child: Container(
                          child: Card(
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    data['image '],
                                    height: 70,
                                    width: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  data['title'],
                                  textAlign: TextAlign.center,
                                  style: h1,
                                ),
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
    );
  }
}
