import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddProductAdminPage extends StatefulWidget {
  String title;
  AddProductAdminPage({this.title});
  @override
  _AddProductAdminPageState createState() => _AddProductAdminPageState();
}

class _AddProductAdminPageState extends State<AddProductAdminPage> {
  TextEditingController nameC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  TextEditingController catagoryC = TextEditingController();
  TextEditingController serialC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController weightC = TextEditingController();
  TextEditingController quantityC = TextEditingController();
  String data = "save address";
  bool ispapular = false;
  bool onsale = false;
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  File _image;

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

  uploadToFirebase() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String url = await uploadFile(
        _image); // this will upload the file and store url in the variable 'url'

    await db.collection("products").add({
      'name': nameC.text,
      'namesearch': setSearchParam(nameC.text),
      'description': descriptionC.text,
      'Product catagory': widget.title,
      'Serial Code': serialC.text,
      'Price': priceC.text,
      //'Added By': user.uid,
      'image ': url,
      "quantity": quantityC.text,
      'weight': weightC.text,
      //'Onsale': onsale,
      'Popular': ispapular,
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

  submit() {
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();

      print(nameC.text);
      print(catagoryC.text);
      print(serialC.text);
      print(descriptionC.text);
      print(priceC.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        "Add Product",
                        style: style,
                      ),
                      TextFormField(
                          onFieldSubmitted: (v) {
                            nameC.text = v;
                          },
                          controller: nameC,
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
                            hintText: "Product Name",
                          )),
                      SizedBox(height: 20.h),
                      TextFormField(
                          onFieldSubmitted: (v) {
                            serialC.text = v;
                          },
                          controller: serialC,
                          keyboardType: TextInputType.phone,
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
                            hintText: "Serial Code Sku-123",
                          )),
                      SizedBox(height: 20.h),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          height: 225.h,
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
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('please select image'),
                          IconButton(
                              onPressed: () {
                                pickImage();
                              },
                              icon: Icon(Icons.camera_alt))
                        ],
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        onFieldSubmitted: (v) {
                          descriptionC.text = v;
                        },
                        controller: descriptionC,
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
                          hintText: "Product Description",
                        ),
                        maxLines: 10,
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                          onFieldSubmitted: (v) {
                            priceC.text = v;
                          },
                          controller: priceC,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                width: 0.w,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            fillColor: Color(0xFFF2F3F5),
                            hintStyle: TextStyle(
                              color: Color(0xFF666666),
                            ),
                            hintText: "Price",
                          )),
                      SizedBox(height: 20.h),
                      TextFormField(
                          onFieldSubmitted: (v) {
                            quantityC.text = v;
                          },
                          controller: quantityC,
                          keyboardType: TextInputType.phone,
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
                            hintText: "enter quantity",
                          )),
                      SizedBox(height: 20.h),
                      TextFormField(
                          onFieldSubmitted: (v) {
                            weightC.text = v;
                          },
                          controller: weightC,
                          keyboardType: TextInputType.phone,
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
                            hintText: "Weight",
                          )),
                      SizedBox(height: 20.h),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          // Text("onsale"),
                          // Switch(
                          //   value: onsale,
                          //   onChanged: (value) {
                          //     setState(() {
                          //       onsale = value;
                          //       print(onsale);
                          //     });
                          //   },
                          // ),
                          Text("ispopular"),
                          Switch(
                            value: ispapular,
                            onChanged: (value) {
                              setState(() {
                                ispapular = value;
                                print(ispapular);
                              });
                            },
                          ),
                        ],
                      ),
                      RaisedButton(
                        padding: EdgeInsets.all(17.0),
                        onPressed: () {
                          uploadToFirebase();

                          print("TEst pass");
                          Fluttertoast.showToast(
                              msg: 'product added successfully');
                        },
                        child: Text(
                          "Add Product",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontFamily: 'Poppins-Medium.ttf',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        color: Color(0xFFBC1F26),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            side: BorderSide(color: Color(0xFFBC1F26))),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
