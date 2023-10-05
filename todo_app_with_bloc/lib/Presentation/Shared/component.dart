import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_with_bloc/Data/Model/TodoModel.dart';
import 'package:todo_app_with_bloc/Domain/Cubit/todo_cubit.dart';
import '../../Constant/string.dart';
import '../../Util/Theme/ThemeDataApp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//-----------------Add Theme Color-----------------
MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
//-----------------build Bottom sheet-----------------
dynamic buildBottomSheet({required BuildContext context, Todo? todoDate}){
  if (isUpdate)
    {
      taskController.text=todoDate!.note!;
      timeController.text=todoDate!.time!;
      dateController.text=todoDate!.date!;
    }
  BlocProvider.of<TodoCubit>(context).isOpen(close: false);
  return scaffoldKey.currentState!.showBottomSheet(
        (context){
          return buildNoteForm(context: context,todoModel:todoDate);
                },
        constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.55),
          ).closed.then((value)
        {
          BlocProvider.of<TodoCubit>(context).isOpen(close: true);
          clear();
          // if(formKey.currentState!.validate()) {
          //   BlocProvider.of<TodoCubit>(context).insertTodo(
          //       todo: Todo(
          //           note:taskController.text ,
          //           date: dateController.text,
          //           time: timeController.text,
          //           status: 'new'));
          //               clear();
          // }
    }
  );
}
//-----------------clear Function-----------------
void clear(){
  isUpdate=false;
  taskController.clear();
  dateController.clear();
  timeController.clear();
}
//-----------------build Text Field-----------------
Padding textField({required VoidCallback onTap ,required TextEditingController controller,required String label, required String msgError,required IconData icon,required TextInputType keyboardType})
{
    return Padding(
    padding:  const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
    child: TextFormField(
      onTap: onTap,
      cursorColor: yellow,
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(color: white, fontSize: 15),
      decoration:  InputDecoration(
          label: Text(label),
          labelStyle: getThemeData().textTheme.displayMedium!.copyWith(
              color: white.withOpacity(0.5),
              fontSize: 15
          ),
          fillColor: green,
          filled: true,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: red,)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: red,)),
          prefixIcon: Icon(icon,color: yellow,size: 40,)
      ),
      validator: (value){
        if(value!.isEmpty)
        {
          return msgError;
        }
      },
    ),
  );
}
//-----------------build Outlined Button-----------------
OutlinedButton buildButton({
  required String text,
  required BuildContext context,
  Todo? todoModel
})
{
  return OutlinedButton(
    onPressed: () {
      if(formKey.currentState!.validate())
        {
          try{
            Navigator.pop(context);
            if(isUpdate)
              {
                BlocProvider.of<TodoCubit>(context).updateTodo(
                    todo: Todo(
                      id: todoModel!.id,
                      note: taskController.text,
                      date: dateController.text,
                      time: timeController.text,
                      status:todoModel!.status
                    ));
              }
            else
            {
              BlocProvider.of<TodoCubit>(context).insertTodo(
                  todo: Todo(
                      note:taskController.text ,
                      date: dateController.text,
                      time: timeController.text,
                      status: 'new'));
            }
            clear();
              }
              catch(e)
                  {
                    print(e.toString());
                  }
        }
    },
    style: OutlinedButton.styleFrom(
      primary: red,
      side: BorderSide(
        color: green
      )
    ),
    child: Text(text),
  );

}
//-----------------build Note Form-----------------
Container buildNoteForm({required BuildContext context,Todo? todoModel})
{
  return Container(
      margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      padding:const EdgeInsets.all(10) ,
     decoration:  BoxDecoration(
      color: yellow.withOpacity(0.2),
      border: Border.all(
        width: 1.2,
        color: green
      ),
      borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(30),
          topLeft: Radius.circular(30)
      ),
    ),
    child:  SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('أُكتُب مَهمتك',style: getThemeData().textTheme.displayMedium!.copyWith(
            fontSize: 18
          ),),
           Form(
             key: formKey,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 textField(onTap: (){}, controller: taskController, label: 'اكتب مَهمتك', msgError: 'لُطفًا اكتُب مَهمتك', icon: Icons.list_alt, keyboardType: TextInputType.text)
                 ,textField(onTap: (){
                   showTimePicker(
                       context: context,
                       initialTime: TimeOfDay.now()
                   ).then((value) {
                     timeController.text=value!.format(context).toString();
                   });
                 },
                     controller: timeController,
                     label: 'زمن مَهمتك',
                     msgError: 'لُطفًا اكتُب زمن مَهمتك',
                     icon: Icons.timer_sharp,
                     keyboardType: TextInputType.datetime)

                 ,textField(onTap: (){
                     showDatePicker(
                         context: context,
                         initialDate: DateTime.now(),
                         firstDate: DateTime.now(),
                         lastDate: DateTime.parse('2030-12-31')
                     ).then((value) {
                       dateController.text =
                           DateFormat.yMMMd().format(value!);
                               });},
                     controller: dateController,
                     label: 'تاريخ مَهمتك',
                     msgError: 'لُطفًا اكتُب تاريخ مَهمتك',
                     icon: Icons.date_range,
                     keyboardType: TextInputType.datetime),
                 buildButton(text:isUpdate? 'تعديل المُهمة':'حفظ المُهمة', context: context,todoModel: todoModel)
               ],
             ),)
        ],
      ),
    ),
  );
}
//-----------------build Message SnackBar-----------------
void showMessage({required BuildContext context,required Widget content,required Color color})
{
  var snackBar= SnackBar(
    margin: const EdgeInsets.symmetric(
      vertical: 20,
      horizontal: 20
    ),
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
    content: content,);
  ScaffoldMessenger. of(context). showSnackBar(snackBar);          }

