import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({Key? key}) : super(key: key);

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  final bookings =
      FirebaseFirestore.instance.collection('bookings').snapshots();

  @override
  Widget build(BuildContext context) {
    Widget bookView(
      DateTime date,
      String eventname,
    ) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 15,
            left: 15,
            right: 25,
          ),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/event.png',
                  fit: BoxFit.cover,
                  height: 50,
                  width: 50,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventname,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '${date.day}/${date.month}/${date.year}',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }

    final displaybook = StreamBuilder<QuerySnapshot>(
        stream: bookings, 
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            Fluttertoast.showToast(msg: "A error Occured");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            Fluttertoast.showToast(msg: "Loading");
          }

          final data = snapshot.requireData;
          return ListView.builder(
              itemCount: data.size,
              itemBuilder: ((context, index) {
                final DocumentSnapshot documentSnapshot =
                    snapshot.data!.docs[index];

                Timestamp t = documentSnapshot['date'];
                DateTime d = t.toDate();

                final date = d;
          print(documentSnapshot['date']);

                return bookView(
                  date,
                  "${data.docs[index]['event_name']}",
                );
              }));
        });



        
    return Scaffold(
        body: Container(
      child: displaybook,
    
    ));
  }
}
