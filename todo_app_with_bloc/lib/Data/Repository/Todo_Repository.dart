import 'dart:convert';
import 'dart:convert';

import 'package:todo_app_with_bloc/Data/Local_Services/Local_services.dart';
import '../Model/TodoModel.dart';

class TodoRepository{

  final LocalServices localDb =LocalServices();
  ///get
  Future<List<Todo>>getAllTodos()async {
    List<Todo>todos=[];
    List<Map<String, dynamic>> value =await localDb.getTodos() ;
    print('Get Todo Before========>$value');
    todos= value.map((e) => Todo.fromJson(e)).toList();
    print('\n\n-----------------# get Todo After 2: $todos-----------------');
    return todos;
  }
  ///insert
  Future<int>insertTodo(Todo todo)=>
     localDb.createTodo(todo: todo);
  ///update
  Future<int>updateTodo(Todo todo)=>
      localDb.updateTodo(todo: todo);
  ///delete
  Future<int>deleteById(int id)=>
      localDb.deleteTodo(id: id);
  ///delete all
  Future<int>deleteAllTodos()=>
      localDb.deleteAllTodos();
}