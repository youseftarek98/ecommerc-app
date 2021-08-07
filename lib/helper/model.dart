
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class User  extends StatelessWidget{
  String? _username ;
  String? _password ;
  String? _phone ;
  int? _id ;


  User(this._password , this._id , this._username);

  User.map (dynamic obj){
    this._username = obj["username"];
    this._password = obj["password"];
    this._phone = obj["phone"];
    this._id = obj["id"];
  }

  String? get username => _username ;
  String? get phone => _phone ;
  String ? get password => _password ;
  int ? get id => _id ;

  Map<String, dynamic> toMap(){
    var map = new Map<String , dynamic>() ;
    map["username"] = _username ;
    map["password"] = _password ;

    if(id != null){
      map["id"] = _id ;
    }
    return map;
  }

  User.fromMap(Map<String , dynamic> map){
    this._username = map["username"] ;
    this._phone = map["phone"] ;
    this._password = map["password"] ;
    this._id = map["id"] ;
  }

  @override
  Widget build(BuildContext context) {
   return Container(
     child: ListTile(
       title: Text("title"),
       subtitle: Text("subTitle"),
       leading: Icon(Icons.save),
       trailing: IconButton(
           onPressed: (){
           }, icon: Icon(Icons.update)),
     ),
   );
  }
}