import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_with_bloc/Data/Repository/Todo_Repository.dart';
import '../../Constant/string.dart';
import '../../Data/Model/TodoModel.dart';
part 'todo_state.dart';
//.....................................................
class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(GetInitial());

  final _repository =TodoRepository();
   List<Todo>allTodos=[];
  List<Todo>doneTodos=[];
  List<Todo>newTodos=[];
  List<Todo>archiveTodos=[];

  void getAllTodos()async
   {
     emit(GetTodoInitial());
     try{
       print('Before Clear List: $allTodos');
       allTodos.clear();
       print('After Clear List: $allTodos');
       allTodos=await _repository.getAllTodos();
       newTodos= allTodos.where((item) => item.status=='new').toList();
       doneTodos= allTodos.where((item) => item.status=='done').toList();
       archiveTodos= allTodos.where((item) => item.status=='archive').toList();

       emit( GetTodoLoaded(todos: allTodos));
     }
     catch(e){
       print('-------------------getCubitError ${e.toString()}-------------------');
        emit(GetTodoFailed());
     }
   }

   void insertTodo({required Todo todo})
   {
     print( 'Before Insert');
     emit(CreateTodoInitial());
     _repository.insertTodo(todo)
         .then((value)
            {
              print('Added record no: $value');
              emit(CreateTodoLoaded());
              print( 'After Insert');
              getAllTodos();
              print( 'After Insert and Get');

            }).catchError((onError)
                  {
                    print('-------------------InsertCubitError ${onError.toString()}-------------------');
                    emit(CreateTodoFailed());
                  }
            );
   }

   void updateTodo({required Todo todo})
   {
     emit(UpdateTodoInitial());
     _repository.updateTodo(todo)
         .then((value) {
       print('Updated record no: $value');
       emit(UpdateTodoLoaded());
       getAllTodos();
     }).catchError(
             (onError)
         {
           print('-------------------UpdateCubitError ${onError.toString()}-------------------');
           emit(UpdateTodoFailed());
         });

   }

   void deleteTodo({required int id})
   {
    emit(DeleteTodoInitial());
    _repository.deleteById(id)
        .then((value) {
      print('Deleted record no: $value');
      emit(DeleteTodoLoaded());
      getAllTodos();
    }).catchError(
            (onError)
        {
          print('-------------------DeleteCubitError ${onError.toString()}-------------------');
          emit(DeleteTodoFailed());
        });

  }

    void onTap(int value)
    {
      currentIndex=value;
      emit(ChangeCurrentIndex());
    }

     void isOpen({required bool close })
     {
       isClose=close;
       emit(BottomSheetOpen(isOpen: close));
     }
}
