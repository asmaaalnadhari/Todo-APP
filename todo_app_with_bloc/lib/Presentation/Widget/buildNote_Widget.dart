import 'package:flutter/material.dart';
import 'package:todo_app_with_bloc/Constant/string.dart';
import 'package:todo_app_with_bloc/Data/Model/TodoModel.dart';
import 'package:todo_app_with_bloc/Domain/Cubit/todo_cubit.dart';
import 'package:todo_app_with_bloc/Presentation/Shared/component.dart';
import 'package:todo_app_with_bloc/Util/Theme/ThemeDataApp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//==============================================================
class NoteItem extends StatelessWidget {
  final Todo todoNote;
  final VoidCallback doneFunction;
  final VoidCallback archiveFunction;

  const NoteItem({super.key, required this.todoNote, required this.doneFunction, required this.archiveFunction});
  @override
  Widget build(BuildContext context) {
    print('todoNote${todoNote}');
    return InkWell(
      onTap: (){
        isUpdate=true;
        buildBottomSheet(context: context,todoDate: todoNote);
      },
      child: Dismissible(
        key: UniqueKey(),
        onDismissed:(de)
           {
              BlocProvider.of<TodoCubit>(context).deleteTodo(id: todoNote.id!);
           },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(left: 10,right: 10),
          decoration:  BoxDecoration(
            color: yellow.withOpacity(0.6),
            border: Border.all(
              color: green
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)

            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(
                width: MediaQuery.sizeOf(context).width *0.4,
                child:  Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(todoNote.note??'',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: getThemeData().textTheme.displayMedium,
                    ),
                    Text('${todoNote.date} | ${todoNote.time}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: getThemeData().textTheme.displayMedium?.copyWith(
                        color: Colors.grey,
                        fontSize: 15
                      ),
                    )

                  ],
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap:archiveFunction ,
                      child: Icon(todoNote.status=='archive'?Icons.archive_rounded:Icons.archive_outlined ,size: 50,color:red,)),
                  const SizedBox(width: 10,),
                  InkWell(
                    onTap:doneFunction ,
                      child: Icon(todoNote.status=='done' ?Icons.check_box:Icons.check_box_outlined ,size: 50,color:red,))

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
