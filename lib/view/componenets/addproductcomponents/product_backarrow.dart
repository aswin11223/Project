import 'package:flutter/material.dart';

class ProductArrow extends StatelessWidget {
   final void Function()? ontapressed;
   final void Function()? ontapress;
  const ProductArrow({super.key,required this.ontapressed,required this.ontapress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontapress,
      child: Container(
        height: 50,
        width: 50,
        
         decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.black),
         child: IconButton(onPressed: ontapressed, icon:Icon(Icons.arrow_back_ios,color: Colors.white,)),
      
      ),
    );
  }
}