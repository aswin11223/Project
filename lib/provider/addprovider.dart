import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_8/model/userinfo.dart';

class Addprovider extends ChangeNotifier{
final CollectionReference userr=FirebaseFirestore.instance.collection('userrr');

void adduser(Userinfo user){
  final data={
    'id':user.id,
    'name':user.username,
    'phone':user.phone,
     'image':user.image,


  };
userr.add(data);

}


}