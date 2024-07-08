import 'package:flutter/material.dart';


class Textfielddd extends StatelessWidget {
  final String hinttexxt;

  Textfielddd({
    super.key,
    required this.hinttexxt,
  });

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
       
         // 80% of screen width
        height: 55, // Static height
        child: Row(
          children: [
            const SizedBox(
              width: 10,
              
            ),
           
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                      
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  fillColor: Theme.of(context).colorScheme.secondary,
                  filled: true,
                  hintText: hinttexxt,
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  prefixIcon: Icon(Icons.search)
                ),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
