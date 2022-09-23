import 'package:final_project/screens/dashboard/bookings/bookings.dart';
import 'package:final_project/screens/dashboard/discover/discover.dart';
import 'package:final_project/screens/dashboard/home/home.dart';
import 'package:final_project/screens/dashboard/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/data_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var currentIndex = 0;
  // ignore: prefer_const_constructors
  final home = HomeScreen();
  // ignore: prefer_const_constructors
  final discover = DiscoverScreen();
  // ignore: prefer_const_constructors
  final bookings = BookingScreen();
  // ignore: prefer_const_constructors
  final profile = ProfileScreen();

  late List<Widget> _screens;
  @override
  void initState() {
    Get.put(DataController(), permanent: true);
    _screens = [home, discover, bookings, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      // ignore: prefer_const_constructors
      body: _screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          // ignore: prefer_const_constructors
          BottomNavigationBarItem(
            // ignore: prefer_const_constructors
            icon: Image.asset(
              //        <-- Image
              'assets/images/home.png',
              height: 30,
              fit: BoxFit.cover,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            // ignore: prefer_const_constructors
            icon: Image.asset(
              //        <-- Image
              'assets/images/search.png',
              height: 30,
              fit: BoxFit.cover,
            ),
            label: 'Discover',
          ),
          // ignore: prefer_const_constructors
          BottomNavigationBarItem(
            // ignore: prefer_const_constructors
            icon: Image.asset(
              //        <-- Image
              'assets/images/booking.jpg',
              height: 30,
              fit: BoxFit.cover,
            ),
            label: 'Bookings',
          ),
          // ignore: prefer_const_constructors
          BottomNavigationBarItem(
            // ignore: prefer_const_constructors
            icon: Image.asset(
              //        <-- Image
              'assets/images/profile.png',
              height: 30,
              fit: BoxFit.cover,
            ),
            label: 'Profile',
          ),
        ],
        onTap: (index) => setState(() => currentIndex = index),
      ),
    );
  }
}
