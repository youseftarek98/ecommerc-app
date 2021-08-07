

import 'package:flutter/cupertino.dart';

import 'products.dart';

class CartItem extends ChangeNotifier{

  List<ProductsModel> _items =[];

  double _totalPrice = 0.0 ;

  void add (ProductsModel items){
    _items.add(items);
    _totalPrice +=items.price_final!.toInt();
    notifyListeners();
  }

  void remove (ProductsModel items){
    _items.remove(items);
    _totalPrice -=items.price_final!.toInt();
    notifyListeners();
  }

  int get counter => _items.length ;


  double  get totalPrice => _totalPrice ;


  List <ProductsModel> get basketItems => _items ;

}