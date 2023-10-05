import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app_with_bloc/Constant/string.dart';
//=============================================
class SqlDB{
  static final SqlDB sqlDb =SqlDB();
  static Database? _db;

  //get Database
  Future<Database?> get db async{
    if(_db==null) {
      return await initialDB();
    }
    else{
      return _db;
    }
  }

  //initial Database
  Future<Database> initialDB()async{
    String dataBasePath=await getDatabasesPath();
    String path=join(dataBasePath,'UST.db');
    Database myDb= await openDatabase(path,onCreate: _onCreate,version: 1,onUpgrade: _onUpgrade);
    return myDb;

  }

  Future<void>_onCreate(Database db,int version)async
  {
    //To Create a Table:
    await db.execute("""
    CREATE TABLE "$tableName"(
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "text" TEXT,
    "date" TEXT , 
    "time" TEXT ,
    "status" TEXT )
    """).then((value)  {
      print('\n\n\n ================Create First Table Success Fully\n\n\n ================');
    }).catchError((onError)
    {
      print('\n\n\n ================ Can not Create Table:${onError.toString()}===========\n\n\n');
    });
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion)async {
    if(oldVersion <newVersion)
      {
       await db.execute('Alter TABLE "$tableName" Add Column newCol Text;');
       print("onCreate Function");
      }

  }
}