import 'package:flutter/material.dart';
import 'package:todo_app_with_bloc/Presentation/Screens/Archive_Tasks.dart';
import 'package:todo_app_with_bloc/Presentation/Screens/Done_Tasks.dart';
import 'package:todo_app_with_bloc/Presentation/Screens/New_Tasks.dart';
//-----------------------------------------------------------------------
String tableName="Task";
//---------------------
List<String> appBarTitle= ['المَهامات الجديدة', 'المَهامات المؤرشفة', 'المَهامات المُنجزة',];
List<Widget> pageScreens=[const NewTasks(), const ArchiveTasks(), const DoneTasks()];
//---------------------
int currentIndex=0;
bool isClose=true;
//---------------------
Color yellow= const Color(0XFFEE9322);
Color green= const Color(0XFF219C90);
Color red =const Color(0XFFD80032);
Color white=Colors.white;
//---------------------
TextEditingController taskController=TextEditingController();
TextEditingController timeController=TextEditingController();
TextEditingController dateController=TextEditingController();
 bool isUpdate=false;
//---------------------
GlobalKey<FormState> formKey = GlobalKey<FormState>();
GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
