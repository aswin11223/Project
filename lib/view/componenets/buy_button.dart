import 'package:flutter/material.dart';

class BuyButton extends StatelessWidget {
   final void Function()? ontap; 
  const BuyButton({super.key,required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
         width:  90,
         height: 40,
         decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.all(Radius.circular(8),
      )
         ),
      child: Center(child: Text('Buy Now',style:  TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
      ),
    );
  }
}