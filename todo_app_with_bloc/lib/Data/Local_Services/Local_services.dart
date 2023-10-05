import 'dart:convert';

import 'package:todo_app_with_bloc/Constant/string.dart';
import 'package:todo_app_with_bloc/Data/Local_DB/Data_Base.dart';
import '../Model/TodoModel.dart';
import 'package:sqflite/sqflite.dart';

class LocalServices{

  final sqlDb=SqlDB.sqlDb;

  ///Add new Todo record:
  Future<int>createTodo({required Todo todo})async
  {
    final Database? db= await sqlDb.db;
     db!.insert(
        tableName,
        todo.toJson()).then(
            (value) {
                return value;
            }).catchError(
         (onError)
             {
               print(onError.toString());
             }
     );
    return 0;
  }

  ///get all Todo records:
  Future<List<Map<String,dynamic>>>getTodos()async
  {
    print('\nget 01==>Local Services\n');
  final Database? db=await sqlDb.db;
  return await db!.query(tableName);
   db!.query(tableName)
       .then((result)
          {
            print('get 02==>Local Services $result');

            return result;
          })
       .catchError((onError)
          {
             print('\n\n\n${onError.toString()}==================>\n\n\n');
           });
  return [];
}

  ///update Todo records:
  Future<int> updateTodo({required Todo todo})async
  {
    final Database? db=await sqlDb.db;
    db!.update(
        tableName,
        todo.toJson(),
        where: "id = ?",
        whereArgs: [todo.id]
        ).then((value) => value);
    return 0;
  }

  ///delete Todo record:
  Future<int> deleteTodo({required int id})async
  {
    final Database? db =await sqlDb.db;
    db!.delete(
        tableName,
      where:"id = ?" ,
      whereArgs:[id]
    ).then((value) => value
    ).catchError((onError)
    {
      print(onError.toString());
    });
    return 0;
  }

  ///delete all Todo records:
  Future<int>deleteAllTodos()async
  {
    final Database? db=await sqlDb.db;
    db!.delete(tableName)
        .then((value) => value
      ).catchError((onError)
        {
          print(onError.toString());
        }
    );
    return 0;
  }
}