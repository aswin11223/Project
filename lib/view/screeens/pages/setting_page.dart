import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/provider/themeprovider/themeprovider.dart';
import 'package:flutter_application_8/view/componenets/buy_button.dart';
import 'package:flutter_application_8/view/componenets/my_button.dart';
import 'package:flutter_application_8/view/componenets/settingscomponents/cupertino_swithch.dart';
import 'package:flutter_application_8/view/componenets/settingscomponents/setting_image.dart';
import 'package:flutter_application_8/view/componenets/settingscomponents/setting_pages.dart';
import 'package:flutter_application_8/view/screeens/adminpanel/adminlogin.dart';
import 'package:flutter_application_8/view/screeens/pages/About_page.dart';
import 'package:flutter_application_8/view/screeens/pages/terms_condition.dart';
import 'package:provider/provider.dart';

class Setting extends StatelessWidget {
  
  const Setting({super.key, });

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth=FirebaseAuth.instance;
    final themeProvider = context.watch<Themeprovider>();
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        child: Column(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight * 0.1,
              child: Center(
                child: const Circleimage(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: screenWidth,
              height: screenHeight * 0.05,
              child: Center(
                child: Text(
                  "Settings",
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: screenWidth,
              height: screenHeight * 0.1,
              child: Darkmode(
                  ontapp: (value) =>
                      context.read<Themeprovider>().toggletheme(),
                  val: themeProvider.isdarkmode),
            ),
            const SizedBox(
              height: 2,
            ),
            Container(
              width: screenWidth,
              height: screenHeight * 0.1,
              child: SettingPages(
                text: "Terms of Service",
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TermsCondition()),
                  );
                },
                icon: const Icon(Icons.dock_rounded),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: screenWidth,
              height: screenHeight * 0.02,
              child: SettingPages(
                text: "About Our App",
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
                icon: const Icon(Icons.person_2_rounded),
              ),
            ),
            SizedBox(height:60,),

            Mybutton(textt: 'Logout', ontapp:(){
              _auth.signOut();
              Navigator.pop(context);
               
            })
          ],
        ),
      ),
    );
  }
}
