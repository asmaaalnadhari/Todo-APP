import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_with_bloc/Constant/string.dart';
import 'package:todo_app_with_bloc/Data/Model/TodoModel.dart';
import 'package:todo_app_with_bloc/Domain/Cubit/todo_cubit.dart';
import '../Shared/component.dart';
//================================================================

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TodoCubit cubit = BlocProvider.of<TodoCubit>(context);
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {
         if (state is CreateTodoLoaded) {
          showMessage(
              context: context,
              content: Text('تم الحفظ..',
                style: TextStyle(
                    fontSize: 18,
                    color: yellow,
                    fontFamily: 'Arabic-Font'
                ),),
              color: green);
                  }
        else if (state is CreateTodoFailed) {
          showMessage(
              context: context,
              content: Text('فشل الحفظ..',
                style: TextStyle(
                    fontSize: 18,
                    color: green,
                    fontFamily: 'Arabic-Font'
                ),),
              color: red);
        }
         if (state is UpdateTodoLoaded) {
           showMessage(
               context: context,
               content: Text('تم التعديل..',
                 style: TextStyle(
                     fontSize: 18,
                     color: yellow,
                     fontFamily: 'Arabic-Font'
                 ),),
               color: green);
         }
      },
      builder: (context, state) {
        return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(title: Text(appBarTitle[currentIndex]),),
            body: pageScreens[currentIndex],
            bottomNavigationBar: Container(
              margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
              decoration: BoxDecoration(
                color: yellow,
                border: Border.all(
                    color: yellow,
                    width: 3
                ),
                borderRadius: const BorderRadius.all(
                    Radius.circular(30)),),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: BottomNavigationBar(
                  backgroundColor: green,
                  items:
                  //================================
                  const [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.list_alt_sharp,
                        color: Colors.white,
                        size: 30,
                      ),
                      label: 'المهام',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.archive_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                      label: 'الأرشيف',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.check_box,
                        color: Colors.white,
                        size: 30,
                      ),
                      label: 'المُنجزة',
                    ),
                  ],
                  //================================
                  selectedItemColor: const Color(0XFFEE9322),
                  showSelectedLabels: true,
                  showUnselectedLabels: false,
                  type: BottomNavigationBarType.fixed,
                  selectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                  onTap: (value) => cubit.onTap(value),
                  currentIndex: currentIndex,
                  //================================
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (isClose) {
                  BlocProvider.of<TodoCubit>(context).isOpen(close: false);
                  buildBottomSheet(context: context);
                }
                else {
                  Navigator.pop(context);
                  }
              },
              child: isClose ?
              const Icon(Icons.edit)
                  :
              const Icon(Icons.close_rounded),
            )

        );
      },
    );
  }
}
