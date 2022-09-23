import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/data_controller.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DataController dataController = Get.find<DataController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.03),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
           image: DecorationImage(
              image: ExactAssetImage('assets/images/backdrop.png'),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
                
                
                SizedBox(
                  height: Get.height * 0.02,
                ),
           
              
              ],
            ),
          ),
        ),
      ),
    );
  }



  }