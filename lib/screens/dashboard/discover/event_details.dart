import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/screens/dashboard/bookings/bookings.dart';
import 'package:final_project/screens/dashboard/discover/discover.dart';
import 'package:final_project/screens/dashboard/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/assets.dart';

class EventDetailsScreen extends StatefulWidget {
  final eventdetails events;
  const EventDetailsScreen({Key? key, required this.events}) : super(key: key);

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
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
        title: Text(
          'Event Details',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            widget.events.image,
                            fit: BoxFit.cover,
                          ))),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue[100]),
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.events.event_name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),

                          Wrap(
                            children: [
                              Icon(Icons.location_on_outlined),
                              Text(widget.events.location),
                            ],
                          ),
                          // ignore: prefer_const_constructors

                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black, fontSize: 36),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Date : ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text:
                                          '${widget.events.date.year}-${widget.events.date.month}-${widget.events.date.day}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20)),
                                  TextSpan(text: '\n'),
                                  TextSpan(
                                      text: 'Time : ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: widget.events.start_time,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20)),
                                  TextSpan(text: ' - '),
                                  TextSpan(
                                      text: widget.events.end_time,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20)),
                                  TextSpan(text: '\n'),
                                  TextSpan(
                                      text: 'Number of Participants: ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: widget.events.participants,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20)),
                                  TextSpan(text: '\n'),
                                  TextSpan(
                                      text: 'Description: ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: '\n'),
                                  TextSpan(
                                      text: widget.events.description,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20)),
                                ],
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue[400], // background
                              onPrimary: Colors.black87, // foreground
                            ),
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection("bookings")
                                  .add({
                                'event_name': widget.events.event_name,
                                'date': widget.events.date,
                                '#_of participants:':
                                    widget.events.participants,
                                'start_time': widget.events.start_time,
                                'end_time': widget.events.end_time,
                                'description': widget.events.description,
                            
                              });

                              Get.snackbar('Success', "You join this event!",
                                  colorText: Colors.white,
                                  backgroundColor: Colors.blue);
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Join Event ',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
