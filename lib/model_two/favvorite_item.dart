import 'package:flutter/foundation.dart';
import 'package:project_ecomerce/models/products.dart';


class Favorite extends ChangeNotifier {
  List<ProductsModel> _item = [];

  double _price = 0.0;

  void addFavorite(ProductsModel items) {
    _item.add(items);
    _price += items.price_final!.toInt();
    notifyListeners();
  }

  void removeFavorite(ProductsModel items) {
    _item.remove(items);
    _price -= items.price_final!.toInt();
    notifyListeners();
  }

  int get counter => _item.length;

  double get price => _price;

  List<ProductsModel> get favorite => _item;
}



