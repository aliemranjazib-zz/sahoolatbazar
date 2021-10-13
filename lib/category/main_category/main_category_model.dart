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
      image:
          'https://o.remove.bg/downloads/858f8efb-2368-4e7f-9846-68141d1a6f8b/135859997-grocery-basket-with-food-assortment-flat-vector-illustration-supermarket-products-in-shopping-handba-removebg-preview.png'),
  MainCategoryModel(
      id: "2",
      name: "FRESH FRUITS & VEGETABLES",
      detail: "FRUITS DETAIL HERE",
      image:
          'https://o.remove.bg/downloads/e4059301-3fea-4325-a7ba-39719ae95a11/56975107-food-in-package-food-delivery-vector-flat-cartoon-illustration-removebg-preview.png'),
  MainCategoryModel(
      id: "3",
      name: "PHARMACY",
      detail: "Grocery, home Care, Baby Care, Dailry",
      image:
          "https://o.remove.bg/downloads/bffdc15d-57b6-4f7c-adb9-06fa380905fd/kissclipart-pharmacy-clipart-bangladesh-pharmacy-business-ca4ce301e0101321-removebg-preview.png"),
];
