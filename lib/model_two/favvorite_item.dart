import 'package:flutter/foundation.dart';
import 'package:project_ecomerce/helper/database_helper.dart';
import 'package:project_ecomerce/models/products.dart';


class Favorite extends ChangeNotifier {
  DatabaseHelper helper = DatabaseHelper();
  List<ProductsModel> _items = [];

  List<ProductsModel>get items => _items ;

  var _totalPrice = 0.0;








  double addPrice() {

    return totalPrice ;
  }

  void added(ProductsModel items) {
    _items.add(items);
    _totalPrice += items.price_final!.toInt();
    notifyListeners();
  }

  void remove(ProductsModel items) {
    _items.remove(items);
    _totalPrice -= items.price_final!.toInt();

    notifyListeners();
  }


  List<ProductsModel>? listItems (){
    List<ProductsModel> newItem = [];
    _items.forEach((items) {
      var contain = newItem.where((element) => element.title.toString() == items.title.toString());
      if(contain.isEmpty){
        newItem.add(items) ;
      }else{
        print("exists") ;
      }
    });
    return newItem;

  }

  int get counter => _items.length;



  clearCarts(ProductsModel items) {
    _items.clear();
    _totalPrice -= totalPrice;
    notifyListeners();
  }




  checkIfProductInCart(ProductsModel items)async{
    if(_items.length > 0){
      var result =  _items.where((element) => items.title.toString() == items.toString()) ;
      if(result.isEmpty)
      {
        return false ;
      }else {
        return true ;
      }
    }else {
      return  false ;
    }

  }

  checkIfProductInCarts(ProductsModel items)async{
    if(_items.length > 0){
      var result =  _items.where((element) => items.title.toString() == items.toString()) ;
      if(result.isEmpty)
      {
        return false ;
      }else {
        return true ;
      }
    }else {
      return  false ;
    }

  }




  double get totalPrice => _totalPrice;

  List<ProductsModel> get basketItems => _items;

  getTotalPrice(){
    for(int i = 0  ; i<listItems ()!.length ; i++){
      _totalPrice += (double.parse(_items[i].price_final_text.toString()) *
          double.parse(_items[i].in_stock.toString())) ;
      print(_totalPrice) ;
      notifyListeners() ;
    }
  }





}