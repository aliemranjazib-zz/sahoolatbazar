import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahoolar_bazar/category/main_category/main_category_model.dart';
import 'package:sahoolar_bazar/utils/decorations.dart';
import 'package:sahoolar_bazar/utils/styles.dart';

class Addcategroies extends StatefulWidget {
  @override
  State<Addcategroies> createState() => _AddcategroiesState();
}

class _AddcategroiesState extends State<Addcategroies> {
  final picker = ImagePicker();
  File _image;
  Future pickImage() async {
    final pickImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickImage != null) {
        _image = File(pickImage.path);
      } else {
        print('no image selected');
      }
    });
  }

  Future<String> uploadFile(File _image) async {
    String downloadURL;
    String postId = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("images")
        .child("post_$postId.jpg");
    await ref.putFile(_image);
    downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  TextEditingController title = TextEditingController();
  TextEditingController category = TextEditingController();

  uploadToFirebase() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String url = await uploadFile(
        _image); // this will upload the file and store url in the variable 'url'

    await db.collection("category").add({
      'category': category.text,
      'title': title.text,
      'namesearch': setSearchParam(title.text),
      'image ': url,
      'Date Added': DateTime.now(),
    });
  }

  setSearchParam(String caseNumber) {
    List<String> caseSearchList = List();
    String temp = "";
    for (int i = 0; i < caseNumber.length; i++) {
      temp = temp + caseNumber[i];
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }

  var _formKey = GlobalKey<FormState>();

  submit() {
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();
      uploadToFirebase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "ADD SUBCATEGORY PRODUCT",
                  textAlign: TextAlign.center,
                  style: h1,
                ),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DropdownButtonFormField(
                        onSaved: (v) {
                          category.text = v;
                        },
                        onChanged: (value) {
                          setState(() {
                            category.text = value;
                          });
                        },
                        // value: genderDefaultValue,
                        hint: Text('select category'),
                        items: maincategorydata
                            .map((e) => DropdownMenuItem(
                                value: e.name, child: Text(e.name.toString())))
                            .toList(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: Color(0xFFF2F3F5),
                          hintStyle: TextStyle(
                            color: Color(0xFF666666),
                          ),
                          hintText: "Product Catagory",
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: title,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'enter title',
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () {
                            pickImage();
                          },
                          child: Text('add images')),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          decoration: decoration(),
                          height: 220,
                          child: _image == null
                              ? Center(
                                  child: Text(
                                    "no images selected",
                                  ),
                                )
                              : Image.file(
                                  _image,
                                ),
                        ),
                      ),
                      MaterialButton(
                          minWidth: double.infinity,
                          color: Colors.blue,
                          onPressed: () {
                            submit();
                          },
                          child: Text(
                            "SAVE",
                          )),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
