import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_ecomerce/models/products.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'model.dart';

class DatabaseHelper {

  final String tableUser = "userTable" ;
  final String columnEmail= "email" ;
  final String columnName = "username" ;
  final String columnPhone = "phone" ;
  final String columnPassword = "password" ;
  static final DatabaseHelper _instance = new DatabaseHelper.internal() ;
  DatabaseHelper.internal();
   factory DatabaseHelper() =>_instance ;
  static Database? _db ;


  Future <Database?> get db async{
    if (_db != null){
      return _db ;
    }
    _db = await initDb();
    return _db ;
  }


  initDb()async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path=  join( documentDirectory.path , "maindb.db");
    var ourdb = await openDatabase( path , version: 1 , onCreate: _onCreate) ;
    return ourdb ;
  }


  /*
  Future initDb()async {
    String path = join(
        await getDatabasesPath() , "CartProduct.db");
    return await openDatabase(path ,
        version: 1 , onCreate: (Database db , int version )async {
          await db.execute('''
      CREATE TABLE $tableCartProduct(
      $columnName TEXT NOT NULL,
      $columnImage TEXT NOT NULL,
      $columnPrice TEXT NOT NULL,
      
      )
      ''');
        }) ;


    Directory documentDirectory = await getApplicationDocumentsDirectory();
    var ourDb= await openDatabase( path , version: 1 , onCreate: _onCreate);
  }


   */
/*
  insert(ProductsModel model)async{
    var dbClient = await database ;

    await dbClient!.insert(tableCartProduct, model.toJson() , conflictAlgorithm: ConflictAlgorithm.replace) ;
  }



 */

  void _onCreate(Database db, int version) async{

 await db.execute("CREATE TABLE $tableUser($columnEmail  TEXT, $columnName TEXT , $columnPassword  TEXT" );

  }

  Future<int> saveUser (ProductsModel pro) async {
    var dbClient = await db ;
    int result = await dbClient!.insert(tableUser, pro.toJson());
    return result ;
  }

  Future<List> grtAllUsers()async {
    var dbClient = await db ;
    var result = await dbClient!.rawQuery("SELECT * FROM $tableUser");
    return result.toList() ;
  }

  Future<ProductsModel?> getUser(int userId) async{
    var dbClient = await db ;
    var result = await dbClient!.rawQuery("SELECT * FROM $tableUser WHERE $columnEmail = $userId") ;
    if(result.length == 0) return null ;
    return new ProductsModel.fromJson(result.first);
  }

  Future<int> deleteUser (int userId) async{
    var dbClient = await db ;
    return await dbClient!.delete(tableUser , where:  "$columnEmail = ?" , whereArgs: [userId]) ;
  }

  Future<int> updateUser (ProductsModel productsModel) async{
    var dbClient = await db ;
    return await dbClient!.update(tableUser, productsModel.toJson() , where: "$columnEmail = ?" , whereArgs: [productsModel.id]);
  }

  Future close()async{
    var dbClient = await db ;
    return dbClient!.close();
  }




}

