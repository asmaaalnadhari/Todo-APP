import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_with_bloc/Domain/Cubit/todo_cubit.dart';
import 'package:todo_app_with_bloc/Presentation/Widget/buildNote_Widget.dart';
import '../../Constant/string.dart';
import '../../Data/Model/TodoModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//-----------------------------------------------
class NewTasks extends StatelessWidget {
  const NewTasks({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit,TodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        TodoCubit cubit =BlocProvider.of<TodoCubit>(context);
          return cubit.newTodos.isNotEmpty ?
          ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) {return NoteItem(todoNote: cubit.newTodos[index],
                  doneFunction: () {
                    cubit.updateTodo(todo: Todo(
                      id: cubit.newTodos[index].id,
                      note:cubit.newTodos[index].note,
                      date: cubit.newTodos[index].date,
                      time: cubit.newTodos[index].time,
                      status: 'done'
                    ));
                  },
                  archiveFunction: () {
                    cubit.updateTodo(todo: Todo(
                        id: cubit.newTodos[index].id,
                        note:cubit.newTodos[index].note,
                        date: cubit.newTodos[index].date,
                        time: cubit.newTodos[index].time,
                        status: 'archive'
                    ));

                  },);},
              separatorBuilder: (context, index) {
                return  Divider(
                  indent: 13,
                  endIndent: 13,
                  color: red,
                  thickness: 2,
                );
              },
              itemCount: cubit.newTodos.length) :
              SizedBox(child: Center(child: Image.asset('images/notfound.gif',)));
        },);
  }
}
