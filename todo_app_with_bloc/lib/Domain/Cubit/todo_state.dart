part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

class GetInitial extends TodoState {}

///Get
class GetTodoInitial extends TodoState {}

class GetTodoLoaded extends TodoState {
  final List<Todo> todos;
  GetTodoLoaded( {required this.todos});
}

class GetTodoFailed extends TodoState {}

///Update
class UpdateTodoInitial extends TodoState {}

class UpdateTodoLoaded extends TodoState {}

class UpdateTodoFailed extends TodoState {}

///Delete
class DeleteTodoInitial extends TodoState {}

class DeleteTodoLoaded extends TodoState {}

class DeleteTodoFailed extends TodoState {}

///Create
class CreateTodoInitial extends TodoState {}

class CreateTodoLoaded extends TodoState {}

class CreateTodoFailed extends TodoState {}

///BottomBar
class ChangeCurrentIndex extends TodoState {}
///BottomSheet
class BottomSheetOpen extends TodoState {
 final bool isOpen ;
 BottomSheetOpen({required this.isOpen});
}