import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  String title;
  ProgressBar({this.title});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Text(title),
            SizedBox(
              width: 30,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
