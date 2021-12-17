import 'package:flutter/material.dart';
import 'package:sahoolar_bazar/adminside/Check_out.dart';
import 'package:sahoolar_bazar/adminside/addcategry.dart';
import 'package:sahoolar_bazar/adminside/addproducts/showmaincaetgory.dart';
import 'package:sahoolar_bazar/adminside/delete/maincategory.dart';
import 'package:sahoolar_bazar/adminside/delete/product_delete/show_category.dart';
import 'package:sahoolar_bazar/adminside/update/maincategory.dart';
import 'package:sahoolar_bazar/adminside/update/product_update/show_category.dart';

class StatsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.38,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard(
                  'ADD SUB CATEGORY',
                  'add product category here',
                  Colors.orange,
                  () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => Addcategroies()));
                  },
                ),
                _buildStatCard(
                  'ADD PRODUCT',
                  'add your products',
                  Colors.red,
                  () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ShowAdminMainCategoryPage()));
                  },
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard(
                  'UPDATE SUB CATEGORY',
                  '',
                  Colors.green,
                  () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => MainCategory()));
                  },
                ),
                _buildStatCard(
                  'Delete Sub Category'.toUpperCase(),
                  '',
                  Colors.teal,
                  () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => MainCategoryDelete()));
                  },
                ),
                _buildStatCard(
                  'Update Product',
                  '',
                  Colors.purple,
                  () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ShowCategoryForUpdate()));
                  },
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard(
                  'Delete Product',
                  'delete product here',
                  Colors.pink,
                  () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ShowCategoryForDelete()));
                  },
                ),
                _buildStatCard(
                  'Check Out',
                  'Deliver orders',
                  Colors.indigo,
                  () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => Checkout()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildStatCard(
      String title, String count, MaterialColor color, Function ontap) {
    return Expanded(
      child: InkWell(
        onTap: ontap,
        child: Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                count,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
