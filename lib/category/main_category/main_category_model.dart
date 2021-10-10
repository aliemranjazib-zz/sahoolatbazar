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
          'https://images.unsplash.com/photo-1515706886582-54c73c5eaf41?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80'),
  MainCategoryModel(
      id: "2",
      name: "FRESH FRUITS & VEGETABLES",
      detail: "FRUITS DETAIL HERE",
      image:
          'https://www.freepnglogos.com/uploads/vegetables-png/buy-high-quality-organic-vegetables-and-fruits-online-7.png'),
  MainCategoryModel(
      id: "3",
      name: "PHARMACY",
      detail: "Grocery, home Care, Baby Care, Dailry",
      image:
          "https://banner2.cleanpng.com/20190705/cee/kisspng-online-pharmacy-pharmacist-pharmaceutical-drug-ind-5d1facc0c077e3.7102569115623569287884.jpg"),
];
