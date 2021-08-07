
import 'package:flutter/material.dart';



class Users extends StatelessWidget {
  const Users({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container();
  }
}




/*

import 'package:flutter/cupertino.dart';

class UserModel {
  String? userId ="" , email =""  , name ="" , pic ="" ;

  UserModel(
  this.userId,
      this.email,
         this.name,
      this.pic,
        )  ;

  UserModel.fromJson(Map <dynamic , dynamic> map){
    if (map == null){
      return ;
    }
      userId = map["userId"] ;
      email = map["email"] ;
      name = map["name"] ;
      pic = map["pic"] ;

  }


  toJson(){
    return {
      "userId" : userId ,
      "email" : email ,
      "name" : name ,
      "pic" : pic ,
    };
  }
}

 */