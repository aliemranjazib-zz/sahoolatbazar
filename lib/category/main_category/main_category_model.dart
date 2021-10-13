import 'package:flutter/material.dart';

class MainCategoryModel {
  String id;
  String name;
  String detail;
  String image;

  MainCategoryModel({this.id, this.name, this.detail, this.image});
}

List<MainCategoryModel> maincategorydata = [
  MainCategoryModel(
      id: "1",
      name: "SUPER MART",
      detail: "Grocery, home Care, Baby Care, Dailry",
      image: 'asset/grocery.png'),
  MainCategoryModel(
      id: "2",
      name: "FRESH FRUITS & VEGETABLES",
      detail: "FRUITS DETAIL HERE",
      image: 'asset/vege.png'),
  MainCategoryModel(
      id: "3",
      name: "PHARMACY",
      detail: "Grocery, home Care, Baby Care, Dailry",
      image: 'asset/pharm.png'),
];
