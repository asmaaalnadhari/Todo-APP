import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_with_bloc/Constant/string.dart';
import 'package:todo_app_with_bloc/Domain/Cubit/todo_cubit.dart';
import 'package:todo_app_with_bloc/Presentation/Widget/buildNote_Widget.dart';
import '../../Data/Model/TodoModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//---------------------------------------------
class DoneTasks extends StatelessWidget {
  const DoneTasks({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit,TodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        TodoCubit cubit =BlocProvider.of<TodoCubit>(context);
        //---------------------
         print('done${cubit.doneTodos}');
          return cubit.doneTodos.isNotEmpty ?
          ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) {
                return NoteItem(todoNote: cubit.doneTodos[index],
                  doneFunction: () {
                    cubit.updateTodo(
                        todo: Todo(
                        id:cubit.doneTodos[index].id,
                        note:cubit.doneTodos[index].note,
                        date:cubit.doneTodos[index].date,
                        time:cubit.doneTodos[index].time,
                        status: 'new'
                    ));
                  },
                  archiveFunction: () {
                    cubit.updateTodo(
                        todo: Todo(
                        id:cubit.doneTodos[index].id,
                        note:cubit.doneTodos[index].note,
                        date:cubit.doneTodos[index].date,
                        time:cubit.doneTodos[index].time,
                        status: 'archive'
                    ));
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
              itemCount:cubit.doneTodos.length) :
              SizedBox(
              child: Center(child: Image.asset(
                'images/notfound.gif',
              )));

      },);
  }
}
