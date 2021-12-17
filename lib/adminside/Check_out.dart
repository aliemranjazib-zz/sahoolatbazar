import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Checkout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final Stream<QuerySnapshot> users =
    //     FirebaseFirestore.instance.collection('checkout').snapshots();
// getdata()async{
//   CollectionReference ref = FirebaseFirestore.instance.collection('events');
// QuerySnapshot eventsQuery = await ref
//     .where("time",).get();
// }

    return Scaffold(
      appBar: AppBar(
        title: Text("Check Out"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('checkout').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final doc = snapshot.data.docs;
            return ListView.builder(
              itemBuilder: (_, i) {
                final data = doc[i];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Wrap(
                      children: [
                        Text(
                          "Address : ${data['address']}",
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(width: 15),
                        Text(
                          "Name: ${data['name']}",
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(width: 15),
                        Text(
                          "Phone: ${data['phone']}",
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(width: 15),
                        Text(
                          "Area: ${data['area']}",
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(width: 15),
                        Text(
                          "Product name: ${data['pname']}",
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(width: 15),
                        Text(
                          "Quantity: ${data['pquantity']}",
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  // child: ListTile(
                  //   leading: Text(data['address']),
                  //   title: Text(data['name']),
                  //   subtitle: Text(data['phone']),
                  //   trailing: Text(data['area']),
                  // ),
                );
              },
              itemCount: doc.length,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
