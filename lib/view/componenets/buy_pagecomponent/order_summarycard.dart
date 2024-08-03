import 'package:flutter/material.dart';



class OrderSummarycard extends StatelessWidget {
  final String price;
  final void Function()? ontap; 
   OrderSummarycard({super.key,required this.price,required this.ontap});

  @override
  Widget build(BuildContext context) {
    final screeheight=MediaQuery.of(context).size.height;
    final screenWidth=MediaQuery.of(context).size.width;

    return Container(
height:  screeheight*0.30,
width: screenWidth*0.9,
margin: const EdgeInsets.all(8),
decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.white54,
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ]
),
child:  Column(
  children: [
    const Row(
      children: [
        SizedBox(height: 40,width: 20,),
        Text('Order Summary',style: TextStyle(fontSize: 23,fontWeight: FontWeight.w600),),
        
      ],
    ),
    const SizedBox(height: 20,),
    Row(
      children: [
        const SizedBox(width: 25,),
        const Text('Payable amount',style: TextStyle(fontWeight: FontWeight.w600),),
        SizedBox(width: screenWidth*0.40,),
        Text(price,style: const TextStyle(fontWeight: FontWeight.w600),)
      ],
    ),
     SizedBox(height: screeheight*0.03,width: screenWidth*0.03,),
    const Padding(
      padding: EdgeInsets.only(left:15),
      child: Text('All the taxes and charges will be calculated during chechout'),
    ),

    SizedBox(height: screeheight*0.05,),
    InkWell(
      onTap: ontap,
      child: Container(
         width:  screenWidth*0.45,
         height: 40,
         decoration: const BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.all(Radius.circular(8),
      )
         ),
      child: const Center(child: Text('Proceed to Checkout',style:  TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
      ),
    )
  ],
),
        

    );
  }
}