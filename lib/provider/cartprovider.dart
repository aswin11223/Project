import 'package:flutter/foundation.dart';
import 'package:flutter_application_8/model/cartmodel.dart';

class Cartprovider extends ChangeNotifier{

  List<Cartitem>_items=[];

  List<Cartitem>get items=>_items;
  void addtocart(Cartitem item){
      _items.add(item);
      notifyListeners();
  }
  void removefromcart(Cartitem item){
    _items.remove(item);
    notifyListeners();
  }
  int get itemcount=>_items.length;
   double get totalPrice {
    return _items.fold(0, (total, current) => total + current.price);
  }



}