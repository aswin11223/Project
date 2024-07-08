import 'package:flutter/material.dart';

class Descriptioncon extends StatelessWidget {
  final String hinttexxt;
 
  final TextEditingController textcont;
    

  Descriptioncon({
    super.key,
    required this.hinttexxt,
  
    required this.textcont,
  });

  @override
  Widget build(BuildContext context) {
    // Get the screen width using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: screenWidth * 0.8, 
        
        
        // 80% of the screen width
        child: TextField(
          controller: textcont,
          
          
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.inversePrimary,
                
              ),
            ),
            focusedBorder: OutlineInputBorder(
              
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            
            filled: true,
            hintText: hinttexxt,
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
