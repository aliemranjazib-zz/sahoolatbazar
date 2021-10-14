import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahoolar_bazar/userpages/productspages/detailproductpage.dart';

go(Widget func, BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => func));
}

class ShowProductPage extends StatelessWidget {
  String title;
  ShowProductPage({this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where("Product catagory", isEqualTo: title)
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
                  child: Card(
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
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
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
