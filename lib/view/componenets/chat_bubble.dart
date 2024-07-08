import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool iscurrentuser;
   ChatBubble({super.key,required this.message,required this.iscurrentuser});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: iscurrentuser?Colors.green:Colors.grey,
      borderRadius: BorderRadius.circular(15)
      ),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 25),
      child: Text(message,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
    );
  }
}