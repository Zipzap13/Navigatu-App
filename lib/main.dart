import 'package:final_project/screens/auth/splash/splash.dart';
import 'package:final_project/screens/dashboard/dashboard.dart';
import 'package:final_project/utils/app_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'N A V I G A T U',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // ignore: prefer_const_constructors
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(color: Colors.black),
            // ignore: prefer_const_constructors
            iconTheme: IconThemeData(color: Colors.grey)),

        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? SplashScreen()
          : DashboardScreen(),
    );
  }
}
