import 'package:flutter/material.dart';
import 'package:sahoolar_bazar/utils/styles.dart';

class TermsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            elevation: 8.0,
            title: Text(
              "SAHULAT BAZAR",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Terms & Condition',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(),
                Container(
                  width: double.infinity,
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                      child: Text(
                        'Updated at 2021-12-18',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  '$terms_data',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
