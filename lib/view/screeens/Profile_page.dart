import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/view/componenets/back_arrow.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        
        
        SizedBox(height: 50,width: 100,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            BackArrow(ontapressed: (){}),
            
            Text("Profile",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 28),),
          
            IconButton(onPressed: (){}, icon:Icon(Icons.settings,size: 28,))
          ],
        )],

    );
  }
}