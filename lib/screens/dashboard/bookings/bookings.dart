import 'package:final_project/screens/dashboard/bookings/completed.dart';
import 'package:final_project/screens/dashboard/bookings/ongoing.dart';
import 'package:final_project/screens/dashboard/bookings/upcoming.dart';
import 'package:flutter/material.dart';
import '../../../core/assets.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  var _selectedStatus = 0;

  // ignore: prefer_const_constructors
  final ongoing = OngoingScreen();
  // ignore: prefer_const_constructors
  final upcoming = UpcomingScreen();

  final completed = CompletedScreen();

  late List<Widget> _screens;
  @override
  void initState() {
    _screens = [ongoing, upcoming, completed];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    
    return Scaffold(
      appBar: AppBar(
            flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Colors.white60, Colors.blue]),
      ),
    ),
        leading: SizedBox(),
        leadingWidth: 0,
        // ignore: prefer_const_constructors
        title: Text(
          'Your Bookings',
          // ignore: prefer_const_constructors
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            // ignore: prefer_const_constructors
            icon: Icon(Icons.filter_alt_rounded),
            onPressed: () {},
          ),
          IconButton(
            // ignore: prefer_const_constructors
            icon: Icon(Icons.calendar_today_sharp),
            onPressed: () {},
          ),
        ],
      ),
      //ONGOING,INCOMING AND COMPLETED EVENTS
      body: Column(
        children: [
          // ignore: prefer_const_constructors
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _BookingStatusButton(
                label: 'Ongoing',
                onTap: _onStatusChange,
                index: 0,
                isActive: _selectedStatus == 0,
              ),
              _BookingStatusButton(
                label: 'Upcoming',
                onTap: _onStatusChange,
                index: 1,
                isActive: _selectedStatus == 1,
              ),
              _BookingStatusButton(
                label: 'Completed',
                onTap: _onStatusChange,
                index: 2,
                isActive: _selectedStatus == 2,
              ),
            ],
          ),
         
          Expanded(child: _screens[_selectedStatus]),
        ],
      ),
    );
  }

  // SETTING UP THE CURRENT STATE
  void _onStatusChange(int index) {
    setState(() => _selectedStatus = index);
  }
  
}


//BOOKING STATUS BUTTON
class _BookingStatusButton extends StatelessWidget {
  const _BookingStatusButton({
    Key? key,
    required this.label,
    required this.onTap,
    required this.isActive,
    required this.index,
  }) : super(key: key);

  final String label;
  final bool isActive;
  final int index;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(index),
      borderRadius: const BorderRadius.all(
        Radius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? Colors.blue[300] : Colors.grey[300],
          // ignore: prefer_const_constructors
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        // ignore: prefer_const_constructors
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        // ignore: prefer_const_constructors
        child: Text(
          label,
          // ignore: prefer_const_constructors
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
