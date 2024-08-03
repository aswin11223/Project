import 'package:flutter/material.dart';
import 'package:flutter_application_8/provider/auth/authservice.dart';
import 'package:flutter_application_8/services/adminauth.dart';
import 'package:flutter_application_8/view/screeens/adminpanel/users_list.dart';
import 'package:page_transition/page_transition.dart';

class DashBoard extends StatelessWidget {
  final AdminAuth adminauth = AdminAuth();
  final AuthService _authService=AuthService();

  DashBoard({Key? key}) : super(key: key);

  void logout() {
    adminauth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DashBoard',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: logout, icon: Icon(Icons.logout)),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 78),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  
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
                      Icon(Icons.person_2, size: 30),
                      SizedBox(height: screenheight * 0.02),
                      Text("USERS"),
                    ],
                  ),
                ),
              ),
              Container(
                width: screenheight * 0.20,
                height: screenheight * 0.20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
