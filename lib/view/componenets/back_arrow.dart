import 'package:flutter/material.dart';

class BackArrow extends StatelessWidget {
   final void Function()? ontapressed;
  const BackArrow({super.key,required this.ontapressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      
       decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.black),
       child: IconButton(onPressed: ontapressed, icon:const Icon(Icons.arrow_back_ios,color: Colors.white,)),
       

    );
  }
}