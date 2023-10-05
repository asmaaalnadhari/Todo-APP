import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_with_bloc/Domain/Cubit/todo_cubit.dart';
import 'package:todo_app_with_bloc/Presentation/Widget/buildNote_Widget.dart';
import '../../Constant/string.dart';
import '../../Data/Model/TodoModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//-----------------------------------------------
class ArchiveTasks extends StatelessWidget {
  const ArchiveTasks({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit,TodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        TodoCubit cubit =BlocProvider.of<TodoCubit>(context);
        return cubit.archiveTodos.isNotEmpty ?
        ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) {
              return NoteItem(todoNote: cubit.archiveTodos[index],
                doneFunction: () {
                  cubit.updateTodo(todo: Todo(
                      id: cubit.archiveTodos[index].id,
                      note:cubit.archiveTodos[index].note,
                      date: cubit.archiveTodos[index].date,
                      time: cubit.archiveTodos[index].time,
                      status: cubit.archiveTodos[index]=='new'?'new':'done'
                  ));
                },
                archiveFunction: () {
                                  },);
            },
            separatorBuilder: (context, index) {
              return  Divider(
                indent: 13,
                endIndent: 13,
                color: red,
                thickness: 2,
              );
            },
            itemCount: cubit.archiveTodos.length) :
        SizedBox(
            child: Center(child: Image.asset(
              'images/notfound.gif')));
      },);
  }
}
