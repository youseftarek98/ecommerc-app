

import 'package:flutter/cupertino.dart';
import 'package:project_ecomerce/helper/database_helper.dart';
import 'package:project_ecomerce/helper/model.dart';
import 'package:project_ecomerce/models/products.dart';
import 'package:sqflite/sqflite.dart';

class CartItemPage extends ChangeNotifier {
  DatabaseHelper helper = DatabaseHelper();
 List<ProductsModel> _items = [];

 List<ProductsModel>get items => _items ;

 var _totalPrice = 0.0;
 var count = 0;








 double addPrice() {

  return totalPrice ;
 }

 void add(ProductsModel items) {
   _items.add(items);
   _totalPrice += items.price_final!.toInt();
   notifyListeners();
 }

 void remove(ProductsModel items) {
   _items.remove(items);
   _totalPrice -= items.price_final!.toInt();

   notifyListeners();
 }

List<ProductsModel>? listItem (){
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


 double totalItems(){
   List<ProductsModel>? myarr = listItem () ;
   double sumItem =0 ;
   for (int i = 0 ; i < myarr!.length ; i++){
     sumItem += double.parse(myarr[i].price_final_text.toString() * getCountByItem(myarr[i])) ;
   }
   return sumItem;
 }

 clearCart(ProductsModel items) {
   _items.clear();
   _totalPrice -= totalPrice;
   notifyListeners();
 }

 String getStringCart (){
   List<ProductsModel>? myarr = listItem () ;
   String str = "" ;
   for(int i = 0 ; i <myarr!.length ; i ++){
     str += myarr[i].title! ;
     str += "," + getCountByItem(myarr[i]).toString();
     str += "," + myarr[i].title.toString();
     str += "#";
   }
   return str;
 }


  checkIfProductInCart(ProductsModel items)async{
    if(_items.length > 0){
    var result =  _items.where((element) => items.id.toString() == items.toString()) ;
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

 int getCountByItem(ProductsModel items){

   for(int i = 0 ; i < _items.length ; i ++){
     if(_items[i].title.toString() == items.title.toString()){
       count ++  ;
     }
   }
   return count ;
 }



  double get totalPrice => _totalPrice;

  List<ProductsModel> get basketItems => _items;

  getTotalPrice(){
    for(int i = 0  ; i<listItem ()!.length ; i++){
      _totalPrice += (double.parse(_items[i].price_final_text.toString()) *
          double.parse(_items[i].in_stock.toString())) ;
   print(_totalPrice) ;
   notifyListeners() ;
    }
  }





}


class CartProvider with ChangeNotifier {
  Map<String, ProductsModel> _cartItems = {};

  Map<String, ProductsModel> get getCartItems {
    return {..._cartItems};
  }

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((key, value) {
      total += value.price_final!.toDouble() * value.in_stock!.toInt();
    });
    return total;
  }

  void addProductToCart(
      String currency, String price, String title, String imageUrl) {
    if (_cartItems.containsKey(title)) {
      _cartItems.update(
          title,
              (exitingCartItem) => ProductsModel(
              id: exitingCartItem.id,
              categoryId: exitingCartItem.categoryId.toString(),
              title: exitingCartItem.title.toString(),
              price: exitingCartItem.price_final_text.toString(),
              in_stock: exitingCartItem.in_stock! + 1.toInt(),
              avatar: exitingCartItem.avatar.toString()));
    } else {
      _cartItems.putIfAbsent(
          title,
              () => ProductsModel(
              id: DateTime.now().toString(),
              //categoryId: ,
              title: title,
              price: price,
              in_stock: 1,
              avatar: imageUrl));
    }
    notifyListeners();
  }



  void reduceItemByOne(ProductsModel items) {
    if (_cartItems.containsKey(items)) {
      _cartItems.update(
          items.title.toString(),
              (exitingCartItem) => ProductsModel(
              id: exitingCartItem.id,
              categoryId: exitingCartItem.categoryId,
              title: exitingCartItem.title,
              price: exitingCartItem.price,
              in_stock: exitingCartItem.in_stock! - 1,
              avatar: exitingCartItem.avatar.toString()));
    }
    notifyListeners();
  }

  void removeItem(ProductsModel items) {
    _cartItems.remove(items);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
  Map<String , ProductsModel> get basketItems => _cartItems ;
}