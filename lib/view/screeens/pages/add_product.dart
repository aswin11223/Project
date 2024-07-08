import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/provider/add_productprovider.dart';
import 'package:flutter_application_8/provider/category_provider.dart';
import 'package:flutter_application_8/view/componenets/addproductcomponents/description_controller.dart';
import 'package:flutter_application_8/view/componenets/addproductcomponents/pick_image.dart';
import 'package:flutter_application_8/view/componenets/addproductcomponents/post_button.dart';
import 'package:flutter_application_8/view/componenets/addproductcomponents/price_controller.dart';
import 'package:flutter_application_8/view/componenets/addproductcomponents/product_backarrow.dart';
import 'package:flutter_application_8/view/componenets/addproductcomponents/product_pagetextfield.dart';
import 'package:flutter_application_8/view/componenets/back_arrow.dart';
import 'package:flutter_application_8/view/componenets/product_components.dart/product_screen.dart';

import 'package:provider/provider.dart';

class AddProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoryProvider>(context).categories;
    final addProductProvider = Provider.of<AddProductProvider>(context);
     final FirebaseAuth _auth=FirebaseAuth.instance;


     void logout(){
      _auth.signOut();
     }
  

    void back() {
      Navigator.pop(context);
    }

    
    void clearcon(){
      addProductProvider.disposeControllers();

    }
    
    void  addimage(){
      addProductProvider.pickImage();
    }

    return Scaffold(
      appBar: AppBar(title: const Text(
                    "Add Yours",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
                  ),
                  
                  centerTitle: true,
                  backgroundColor:Theme.of(context).colorScheme.secondary ,
                  leading: IconButton(onPressed:(){} , icon:ProductArrow(ontapressed:back, ontapress: clearcon) ),
                  ),
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
            
            
            
                
                
                
                if (addProductProvider.image != null)
                  Image.file(
                    addProductProvider.image!,
                    height: 120,
                  ),
                SizedBox(
                  height: 30,
                 
                ),
                
                PickImage(text: "image", ontap: addimage),
                
                
                ProductField(
                    hinttexxt: "Art Name",
                    textcont: addProductProvider.nameController),
                ProductField(
                    hinttexxt: "Artist Name",
                    textcont: addProductProvider.artistNameController),
                Descriptioncon(
                    hinttexxt: "Description",
                    textcont: addProductProvider.descriptionController),
                Pricecon(
                    hinttexxt: "Price",
                    textcont: addProductProvider.priceController),
                const SizedBox(height: 10),
            
                
                PostButton(text: "Post", ontap: (){
                  addProductProvider.addProduct(context, categories);
                }),
                  Wrap(
                spacing: 8.0,
                children: categories.map((category) {
                  return ChoiceChip(
                    label: Text(category.name),
                    selected: addProductProvider.selectedCategoryId == category.id,
                    onSelected: (isSelected) {
                      addProductProvider.selectCategory(isSelected ? category.id : null);
                    },
                    selectedColor: Colors.brown,
                  );
                }).toList(),
              ),
              
            
                ElevatedButton(onPressed: (){
                  _auth.signOut();

                }, child:Text("logout"))
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
