import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'model.dart';

class DatabaseHelper {

  final String tableUser = "userTable" ;
  final String columnEmail= "email" ;
  final String columnName = "username" ;
final String columnPhone = "phone" ;
final String columnPassword = "phone" ;

  static final DatabaseHelper _instance = new DatabaseHelper.internal() ; /////////

 DatabaseHelper.internal() ; ///////////
  factory DatabaseHelper() => _instance ; ///////////f

static Database? _db ;

 Future <Database?> get db async{
  if (_db != null){
    return _db ;
  }
 _db = await initDb();
}



  initDb()async {
   Directory documentDirectory = await getApplicationDocumentsDirectory();
   String path = join(documentDirectory.path , "main_db.db");
   var ourDb= await openDatabase( path , version: 1 , onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async{
  await db.execute("CREATE TABLE $tableUser($columnEmail  TEXT, $columnName TEXT , $columnPhone INTEGER PRIMARY KEY , $columnPassword" );
  }

  Future<int> saveUser (User user) async {
  var dbClient = await db ;
  int result = await dbClient!.insert(tableUser, user.toMap());
  return result ;
  }

  Future<List> grtAllUsers()async {
    var dbClient = await db ;
    var result = await dbClient!.rawQuery("SELECT * FROM $tableUser");
    return result.toList() ;
  }

  Future<User?> getUser(int userId) async{
    var dbClient = await db ;
    var result = await dbClient!.rawQuery("SELECT * FROM $tableUser WHERE $columnEmail = $userId") ;
    if(result.length == 0) return null ;
    return new User.fromMap(result.first);
  }

  Future<int> deleteUser (int userId) async{
    var dbClient = await db ;
    return await dbClient!.delete(tableUser , where:  "$columnEmail = ?" , whereArgs: [userId]) ;
  }

  Future<int> updateUser (User user) async{
    var dbClient = await db ;
    return await dbClient!.update(tableUser, user.toMap() , where: "$columnEmail = ?" , whereArgs: [user.id]);
  }

  Future close()async{
    var dbClient = await db ;
    return dbClient!.close();
  }


}