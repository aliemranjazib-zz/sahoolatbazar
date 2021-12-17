import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CovidBarChart extends StatefulWidget {
  @override
  State<CovidBarChart> createState() => _CovidBarChartState();
}

class _CovidBarChartState extends State<CovidBarChart> {
  int totalproducts = 0;
  int totalOrder = 0;
  int totalCategory = 0;

  gettotalProducts() async {
    final QuerySnapshot qSnap =
        await FirebaseFirestore.instance.collection('products').get();
    setState(() {
      totalproducts = qSnap.docs.length;
    });

    return totalproducts;
  }

  gettotalCategory() async {
    final QuerySnapshot qSnap =
        await FirebaseFirestore.instance.collection('category').get();
    setState(() {
      totalCategory = qSnap.docs.length;
    });
    return totalCategory;
  }

  gettotalOrder() async {
    final QuerySnapshot qSnap =
        await FirebaseFirestore.instance.collection('checkout').get();
    setState(() {
      totalOrder = qSnap.docs.length;
    });
    print(totalOrder);
    return totalOrder;
  }

  @override
  void initState() {
    gettotalProducts();
    gettotalOrder();
    gettotalCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Container(
        child: Column(
          children: <Widget>[
            //  ElevatedButton(onPressed: () {}, child: Text("aaaaaa")),
            Container(
              padding: const EdgeInsets.all(20.0),
              alignment: Alignment.centerLeft,
              child: Text(
                '',
                style: const TextStyle(
                  fontSize: 2.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Card(
                elevation: 10,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("Total Products : $totalproducts"),
                  ),
                )),
            Card(
                elevation: 10,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("Total Categories : $totalCategory"),
                  ),
                )),
            Card(
                elevation: 10,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("Total Orders : $totalOrder"),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
