import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_8/model/user_model.dart';
import 'package:flutter_application_8/provider/profileprovider/profileprovider.dart';
import 'package:flutter_application_8/view/componenets/profilecomponents/profilecomp.dart';
import 'package:flutter_application_8/view/screeens/pages/setting_page.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  final String email;
  final String usere;
  final String image;
  const ProfilePage({super.key,required this.usere,required this.email,required this.image});
  

  @override
  Widget build(BuildContext context) {
      final profileProvider = Provider.of<Profileprovider>(context);
    return  Scaffold(
      
      appBar: AppBar(
        actions:[ IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Setting(name: usere,)));


        }, icon: const Icon(Icons.settings,size: 30,)),],
        title: const Text('Profile',style: TextStyle(fontWeight: FontWeight.w800),),
      centerTitle:  true,),
      body: Column(


        children: [

        SizedBox(height: 30,width: 50,),

          Center(child: CircleAvatar(backgroundImage: NetworkImage(image),radius: 50,)),
          Text(usere,style:const TextStyle(fontSize:25,fontWeight: FontWeight.w600),),
          Text(email,style:const TextStyle(fontSize:15,fontWeight: FontWeight.w500))

        ],

      ),
    );
  }
}