import 'package:flutter/material.dart';

class ImageAdd extends StatelessWidget {
   final void Function()? ontapressed;
  const ImageAdd({super.key,required this.ontapressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      
       decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black),
       child: Center(child: IconButton(onPressed: ontapressed, icon:Icon(Icons.add,color: Colors.white,))),

    );
  }
}