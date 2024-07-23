import 'package:flutter/material.dart';

class Circleimage extends StatelessWidget {
  const Circleimage({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 60,
      backgroundImage: NetworkImage('https://tse2.mm.bing.net/th?id=OIP.mP1BqsoJGuuFwgTSPEZS3AHaHa&pid=Api&P=0&h=180'),
    
    );
  }
}