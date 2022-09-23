import 'package:flutter/material.dart';
class OngoingScreen extends StatefulWidget {
  const OngoingScreen({Key? key}) : super(key: key);

  @override
  State<OngoingScreen> createState() => _OngoingScreenState();
}

class _OngoingScreenState extends State<OngoingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(child: Text('ongoing')),
    );
    
  }
}