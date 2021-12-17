import 'package:flutter/material.dart';
import 'package:sahoolar_bazar/adminside/ui/bar.dart';
import 'package:sahoolar_bazar/adminside/ui/custom_app_bar.dart';
import 'package:sahoolar_bazar/adminside/ui/stat_grid.dart';
import 'package:sahoolar_bazar/components/mydrawer.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: CustomAppBar(),
      // drawer: MyDrawer(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(),
          //    _buildStatsTabBar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: StatsGrid(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: CovidBarChart(),
            ),
          ),
        ],
      ),
    );
  }

  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Admin Area',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// class AdminPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //  drawer: MyDrawer(),
//       appBar: AppBar(
//         title: Text('ADMIN AREA'),
//         elevation: 0.0,
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () {
//               auth.signOut().whenComplete(() => Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (c) => AdminLoginPage()),
//                   (route) => false));
//             },
//             icon: Icon(Icons.logout),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(14.0),
//         child: GridView(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisSpacing: 12, mainAxisSpacing: 10, crossAxisCount: 2),
//           children: [
//             InkWell(
//               onTap: () {
//                 Navigator.of(context)
//                     .push(MaterialPageRoute(builder: (_) => Addcategroies()));
//               },
//               child: Container(
//                 width: 200,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   color: Colors.amber,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [],
//                 ),
//                 child: Center(
//                     child: Text(
//                   'ADD SUB CATEGORY',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.black, fontSize: 20),
//                 )),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (_) => ShowAdminMainCategoryPage()));
//               },
//               child: Container(
//                 width: 200,
//                 height: 200,
//                 decoration: BoxDecoration(color: Colors.amber, boxShadow: []),
//                 child: Center(
//                     child: Text(
//                   'ADD PRODUCT',
//                   style: TextStyle(color: Colors.black, fontSize: 20),
//                 )),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.of(context)
//                     .push(MaterialPageRoute(builder: (_) => MainCategory()));
//               },
//               child: Container(
//                 width: 200,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   boxShadow: [],
//                   color: Colors.amber,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Center(
//                     child: Text(
//                   'UPDATE SUB CATEGORY',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.black, fontSize: 20),
//                 )),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.of(context).push(
//                     MaterialPageRoute(builder: (_) => MainCategoryDelete()));
//               },
//               child: Container(
//                 width: 200,
//                 height: 200,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.amber,
//                     boxShadow: []),
//                 child: Center(
//                     child: Text(
//                   'Delete Sub Category',
//                   style: TextStyle(color: Colors.black, fontSize: 20),
//                 )),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.of(context).push(
//                     MaterialPageRoute(builder: (_) => ShowCategoryForUpdate()));
//               },
//               child: Container(
//                 width: 200,
//                 height: 200,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.amber,
//                     boxShadow: []),
//                 child: Center(
//                     child: Text(
//                   'Update Product',
//                   style: TextStyle(color: Colors.black, fontSize: 20),
//                 )),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.of(context).push(
//                     MaterialPageRoute(builder: (_) => ShowCategoryForDelete()));
//               },
//               child: Container(
//                 width: 200,
//                 height: 200,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.amber,
//                     boxShadow: []),
//                 child: Center(
//                     child: Text(
//                   'Delete Product',
//                   style: TextStyle(color: Colors.black, fontSize: 20),
//                 )),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => Checkout(),
//                   ),
//                 );
//               },
//               child: Container(
//                 height: 200,
//                 width: 200,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: Colors.amber,
//                 ),
//                 child: Center(
//                     child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     "Check Out",
//                     style: TextStyle(color: Colors.black, fontSize: 20),
//                   ),
//                 )),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
