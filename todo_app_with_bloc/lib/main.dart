import 'package:flutter/material.dart';
import 'package:todo_app_with_bloc/Domain/Cubit/todo_cubit.dart';
import 'package:todo_app_with_bloc/Presentation/Shared/Bloc_Observer/BlocObserver.dart';
import 'Presentation/Screens/Home_Layout_page.dart';
import 'Util/Theme/ThemeDataApp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer=MyBlocObserver();
  runApp(
       MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getThemeData(),
        home: BlocProvider(
            create: (BuildContext context)=>TodoCubit()..getAllTodos(),
        child: const Directionality(
            textDirection: TextDirection.rtl,
            child: HomePage()),
    ),

  ));
}

// import 'package:flutter/material.dart';
//
// void main() => runApp(new MyApp());
//
// class MyApp extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'Flutter Demo',
//       theme: new ThemeData(
//
//         primarySwatch: Colors.blue,
//       ),
//       home: new MyHomePage(title: 'Flutter Bottom sheet'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, this.title}) : super(key: key);
//   final String? title;
//
//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar:  AppBar(
//         title:  Text(widget.title!),
//       ),
//       floatingActionButton: new FloatingActionButton(
//         onPressed: (){
//           _settingModalBottomSheet(context);
//         },
//         child: new Icon(Icons.add),
//       ),
//     );
//   }
// }
//
//
// void _settingModalBottomSheet(context){
//   showModalBottomSheet(
//       context: context,
//       builder: (BuildContext bc){
//         return Container(
//           child: new Wrap(
//             children: <Widget>[
//               new ListTile(
//                   leading: new Icon(Icons.music_note),
//                   title: new Text('Music'),
//                   onTap: () => {}
//               ),
//               new ListTile(
//                 leading: new Icon(Icons.videocam),
//                 title: new Text('Video'),
//                 onTap: () => {},
//               ),
//             ],
//           ),
//         );
//       }
//   );
// }