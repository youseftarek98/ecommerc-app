
import 'package:flutter/material.dart';

class Styles{
  static ThemeData themeData(bool isDarkThem , BuildContext context){
    return ThemeData(
      scaffoldBackgroundColor: isDarkThem ? Colors.black : Colors.grey.shade300 ,
      primarySwatch:Colors.purple ,
      primaryColor:  isDarkThem ? Colors.black : Colors.grey.shade300 ,
      accentColor: Colors.deepPurple ,
      backgroundColor: isDarkThem ? Colors.grey.shade700 :Colors.white ,
      indicatorColor: isDarkThem ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      buttonColor: isDarkThem ? Color(0xff383838) : Color(0xffF1F5FB) ,
      hintColor: isDarkThem ? Colors.grey.shade300 : Colors.grey.shade800 ,
      highlightColor: isDarkThem ? Color(0xff372901) : Color(0xffFCE192) ,
      hoverColor: isDarkThem ? Color(0xff3A3A38) : Color(0xff42855F4) ,
      focusColor: isDarkThem ? Color(0xff0B2512) : Color(0xffABDAB5) ,
      disabledColor: Colors.grey ,
      textSelectionColor: isDarkThem ? Colors.white : Colors.black ,
      cardColor: isDarkThem ? Color(0xFF151515) : Colors.white ,
      canvasColor: isDarkThem ? Colors.black : Colors.grey[50] ,
      brightness: isDarkThem ?Brightness.dark : Brightness.light ,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
        colorScheme: isDarkThem ? ColorScheme.dark() : ColorScheme.light(),) ,
    appBarTheme: AppBarTheme(
      elevation: 0.0 ,

    ) ,
    );
  }
}