import 'package:flutter/material.dart';

class SettingPages extends StatelessWidget {
  final String text;
  final void Function()? ontap;
    final Icon icon;
  
  const SettingPages({super.key,required this.text,required this.ontap,required this.icon});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: [
            
            IconButton(onPressed: (){}, icon: icon),
            Text(text,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
            SizedBox(width: 120,),
            IconButton(onPressed: ontap, icon: Icon(Icons.arrow_forward_ios,size:30,))
      
          ],
      ),
    );
  }
}