
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Constant/string.dart';
import '../../Presentation/Shared/component.dart';

ThemeData getThemeData()=>ThemeData(
  fontFamily: 'Arabic-Font',
  primarySwatch: buildMaterialColor(green),
  textTheme:  TextTheme(
    displayLarge: const TextStyle(
      fontSize: 25,
      color: Colors.white
    ),
    displayMedium: TextStyle(
          fontSize: 20,
          color: green
      )
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
         systemStatusBarContrastEnforced:true,
        statusBarIconBrightness:Brightness.dark
  )

));