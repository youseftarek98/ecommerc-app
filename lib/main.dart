import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_ecomerce/consts/colors.dart';

import 'package:project_ecomerce/provider/dark_theme_provider.dart';
import 'package:project_ecomerce/screens/bottom_bar.dart';
import 'package:project_ecomerce/screens/feeds.dart';
import 'package:project_ecomerce/widget/feeds_products.dart';
import 'package:provider/provider.dart';


import 'model_two/cart_item.dart';
import 'model_two/favvorite_item.dart';
import 'screens/cart.dart';
import 'screens/home.dart';
import 'screens/login_in.dart';
import 'screens/sign_up_page.dart';
import 'screens/landing_pagr.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider(
    create: (context) => CartItemPage(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  Favorite _favorite =Favorite() ;


  final Future<FirebaseApp> _initialization =Firebase.initializeApp();

  @override
  void initState() {
    getCurrentTheme();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
      future: _initialization,
      builder: (context, snapshot) {
        if(snapshot.connectionState== ConnectionState.waiting){
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ) ;
        }
        else if(snapshot.hasError){
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text("Error occured"),
              ),
            ),
          ) ;
        }
        return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) {
                return themeChangeProvider;
              }) ,

              ChangeNotifierProvider(create: (_) {
                return _favorite;
              }) ,

            ],
            child:
                Consumer<DarkThemeProvider >(builder: (context, themeData, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: Styles.themeData(themeChangeProvider.darkTheme, context),
                home: PageView(
                  children: [
                    SignUpPage() ,
                     //BottomBarScreens(),
                    //SignUpScreen()
                  ],
                ), //HomePage() ,
                routes: {
                  "Home": (context) => Home(),
                  "FeedProducts": (context) => FeedProducts(),
                  "loginScreen" : (context) =>LoginScreen(),
                  "signUpScreen" : (context) =>SignUpScreen(),
                  "SignUpPage" : (context) =>SignUpPage(),
                  "cart" : (context) =>Cart(),
                  "Feeds" : (context) =>Feeds(),
                  "BottomBarScreens" : (context) =>BottomBarScreens(),
                },
              );
            }));
      }
    );
  }
}

