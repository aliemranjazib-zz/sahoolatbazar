import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sahoolar_bazar/adminside/addproducts/addproductAdminPage.dart';

import 'addproduct_update.dart';

class ShowCategoryAdminPageUpdate extends StatelessWidget {
  String title;
  ShowCategoryAdminPageUpdate({this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("category")
            .where("category", isEqualTo: title)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => AddProductAdminPageUpdate(
                                  title: data[index]['title'],
                                  id: data[index].id,
                                )));
                  },
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(data[index]['title']),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
