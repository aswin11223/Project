import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/provider/themeprovider/themeprovider.dart';
import 'package:flutter_application_8/view/componenets/settingscomponents/cupertino_swithch.dart';
import 'package:flutter_application_8/view/componenets/settingscomponents/setting_image.dart';
import 'package:flutter_application_8/view/componenets/settingscomponents/setting_pages.dart';
import 'package:flutter_application_8/view/screeens/adminpanel/adminlogin.dart';
import 'package:flutter_application_8/view/screeens/pages/About_page.dart';
import 'package:flutter_application_8/view/screeens/pages/terms_condition.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Setting extends StatelessWidget {
  final String name;
  const Setting({super.key,required this.name});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<Themeprovider>();

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
      body: Column(
        children: [
          SizedBox(
            width: 500,
            height: 80,
          ),
          const Circleimage(),
          const SizedBox(
            height: 10,
          ),
          Text(name,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 25),),
         Darkmode(ontapp: (value) => context.read<Themeprovider>().toggletheme(), val:themeProvider.isdarkmode),
         const SizedBox(   height: 10,),
         SettingPages(text: "Terms of Service", ontap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsCondition()));
         },icon: const Icon(Icons.dock_rounded),),
         const SizedBox(height: 10,),
         SettingPages(text: "About Our App", ontap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutPage()));
         },icon: const Icon(Icons.person_2_rounded),),
         GestureDetector(child: Text('Admin'),
            onTap: () {
              Navigator.push(context, PageTransition(child: Adminpanel(), type:PageTransitionType.bottomToTop));
            },
            )
        ],
      ),
    );
  }
}
