import 'package:dio/dio.dart';

class ProductsModel {
  var _id;
  var _name;
  var _title;
  var _category_id;
  var _description;
  var _price;
  var _discount;
  var _discount_type;
  var _currency;
  var _in_stock;
  var _avatar;
  var _price_final;
  var _price_final_text;

  int? get id => _id;

  int? get categoryId => _category_id;

  int? get price => _price;

  int? get in_stock => _in_stock;

  int? get price_final => _price_final;

  int? get discount => _discount;

  String? get name => _name;

  String? get avatar => _avatar;

  String? get title => _title;

  String? get description => _description;

  String? get discount_type => _discount_type;

  String? get currency => _currency;

  String? get price_final_text => _price_final_text;

  ProductsModel({
    id,
    name,
    avatar,
    categoryId,
    price,
    in_stock,
    price_final,
     discount,
     title,
     description,
     discount_type,
    bool? currency,
    price_final_text,



  //  bool? id,
   // bool? name,
   // bool? avatar,
   // bool? categoryId,
  //  bool? price,
   // bool? in_stock,
   // bool? price_final,
   // bool? discount,
   // bool? title,
   // bool? description,
   // bool? discount_type,
   // bool? currency,
   // bool? price_final_text,

  }) {
    _id = id ;
    _discount = discount;
    _in_stock = in_stock;
    _price = price;
    _category_id = categoryId;
    _price_final = price_final;
    _name = name as String?;
    _avatar = avatar as String?;
    _title = avatar;
    _description = avatar ;
    _discount_type = avatar ;
    _currency = avatar ;
    _price_final_text = avatar ;
  }


  Future<List<ProductsModel>>? getProducts() async {
    List<ProductsModel> list = [];
    var response =
        await Dio().get("https://retail.amit-learning.com/api/products");
    var products = response.data["products"];

    for (var item in products) {
      list.add(ProductsModel.fromJson(item));
    }
    return list;
  }

  ProductsModel.fromJson(Map<String, dynamic> json) {
    _id = json["id"];
    _name = json["name"];
    _avatar = json["avatar"];
    _title = json["title"];
    _category_id = json["category_id"];
    _description = json["description"];
    _price = json["price"];
    _discount = json["discount"];
    _discount_type = json["discount_type"];
    _currency = json["currency"];
    _in_stock = json["in_stock"];
    _price_final = json["price_final"];
    _price_final_text = json["price_final_text"];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = {};
    data["price_final_text"] = this._price_final_text!.map((v) => v.toJson());
    data["name"] = this._name!.map((v) => v.toJson()).toList();
    data["title"] = this._title!.map((v) => v.toJson()).toList();
    data["category_id"] = this._category_id!.map((v) => v.toJson()).toList();
    data["description"] = this._description!.map((v) => v.toJson()).toList();
    data["price"] = this._price!.map((v) => v.toJson()).toList();
    data["discount"] = this._discount!.map((v) => v.toJson()).toList();
    data["discount_type"] =
        this._discount_type!.map((v) => v.toJson()).toList();
    data["price_final"] = this._price_final!.map((v) => v.toJson()).toList();
    data["avatar"] = this._avatar!.map((v) => v.toJson()).toList();
    data["in_stock"] = this._in_stock!.map((v) => v.toJson()).toList();
    data["currency"] = this._currency!.map((v) => v.toJson()).toList();
    data['id'] = this._id..map((v) => v.toJson()).toList();

    return data;
  }
}
