import 'package:final_project/core/assets.dart';
import 'package:final_project/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // ignore: prefer_const_constructors
      await Future.delayed(Duration(milliseconds: 500));
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        // ignore: prefer_const_constructors
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
          // ignore: prefer_const_constructors
          gradient: LinearGradient(
            // ignore: prefer_const_literals_to_create_immutables
            colors: [Colors.blue, Colors.indigo],
            // ignore: prefer_const_literals_to_create_immutables
            stops: [0, 1],
          ),
        ),
        child: Center(
          child: Image.asset(
            Assets.jpglogo,
            width: 100,
          ),
        ),
      ),
    );
  }
}