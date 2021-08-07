

import 'package:dio/dio.dart';

class ModelCategories {
  int? _id;
  String? _name;
  String? _avatar;

  int? get id => _id;

  String? get name => _name;

  String? get avatar => _avatar;

  ModelCategories({
    bool? id,
    bool? name,
    bool? avatar,
  }) {
    _id = id as int?;
    _name = name as String?;
    _avatar = avatar as String?;
  }

  Future<List<ModelCategories>>? getData() async {
    List<ModelCategories> list = [];
    var response =
    await Dio().get("https://retail.amit-learning.com/api/categories");
    var categories = response.data["categories"];

    for (var item in categories) {
      list.add(ModelCategories.fromJson(item));
    }
    return list;
  }

  ModelCategories.fromJson(Map<String, dynamic> json) {
    _id = json["id"];
    _name = json["name"];
    _avatar = json["avatar"];
  }


}