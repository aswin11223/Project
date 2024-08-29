import 'package:flutter/material.dart';
import 'package:flutter_application_8/provider/auth/authservice.dart';
import 'package:flutter_application_8/provider/orderprivedr.dart';
import 'package:flutter_application_8/services/adminauth.dart';
import 'package:flutter_application_8/view/screeens/adminpanel/Admin_Order_manage.dart';
import 'package:flutter_application_8/view/screeens/adminpanel/addcategory.dart';
import 'package:flutter_application_8/view/screeens/adminpanel/users_list.dart';

import 'package:flutter_application_8/view/screeens/pages/buy_pages/order_staus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatelessWidget {
  final AdminAuth adminauth = AdminAuth();
  final AuthService authService = AuthService();


  DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dg=Provider.of<OrderProviderr>(context).orders;
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        authService.signOut();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'DashBoard',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          
        ),
        body: Column(
           
          children: [
            const SizedBox(height: 78),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child:  AdminOrderManagementPage(),
                      ),
                    );
                  },
                  child: Container(
                    width: screenheight * 0.20,
                    height: screenheight * 0.20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.person_2, size: 30),
                        SizedBox(height: screenheight * 0.02),
                        const Text("ORDERS"),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){ Navigator.push(context, MaterialPageRoute(builder: (context)=>Admincategory()));},
                  child: Container(
                    width: screenheight * 0.20,
                    height: screenheight * 0.20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.production_quantity_limits, size: 30),
                          SizedBox(height: screenheight * 0.02),
                          const Text("category"),
                        ],
                      ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
