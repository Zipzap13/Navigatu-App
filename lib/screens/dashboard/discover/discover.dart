import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/screens/dashboard/discover/create_event.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'event_details.dart' show EventDetailsScreen;

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  bool searching = false;
  // ignore: non_constant_identifier_names
  final db_events = FirebaseFirestore.instance.collection('events').snapshots();

  @override
  Widget build(BuildContext context) {
    Widget eventView(
      String location,
      String event_name,
      String event_type,
      String description,
      String start_time,
      String end_time,
      String participants,
      DateTime date,
      String image,
      String id,
    ) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventDetailsScreen(
                      events: eventdetails(
                        location,
                        event_name,
                        event_type,
                        description,
                        start_time,
                        end_time,
                        participants,
                        date,
                        image,
                        id,
                      ),
                    )),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Container(
            // margin: EdgeInsets.only(right: 15, bottom: 10, top: 10),
            decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(20)),
            width: 300,
            height: 270,
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 1),
                            child: CircleAvatar(
                              child: IconButton(
                                alignment: Alignment.topRight,
                                onPressed: () async {
                                  showAlertDialog(BuildContext context) {
                                    // set up the buttons
                                    Widget cancelButton = TextButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                    Widget continueButton = TextButton(
                                      child: Text("Continue"),
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection("events")
                                            .doc(id)
                                            .delete()
                                            .whenComplete(() =>
                                                Fluttertoast.showToast(
                                                    msg: "Succesfully Removed"))
                                            .whenComplete(() =>
                                                Navigator.of(context).pop());
                                      },
                                    );

                                    // set up the AlertDialog
                                    AlertDialog alert = AlertDialog(
                                      title: Text("Cancel Event"),
                                      content: Text(
                                          "Are you sure you want to delete this event?"),
                                      actions: [
                                        cancelButton,
                                        continueButton,
                                      ],
                                    );

                                    // show the dialog
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alert;
                                      },
                                    );
                                  }

                                  showAlertDialog(context);
                                },
                                icon: Icon(Icons.close),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: Image.network(
                        image,
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 5,
                    ),
                    child: Text(
                      event_name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: Wrap(
                        children: [
                          Text(event_type),
                          Icon(Icons.location_on_outlined),
                          Text(location),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final displayEvents = StreamBuilder<QuerySnapshot>(
        stream: db_events,
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
                String eventImage = '';
                try {
                  List media = documentSnapshot['media'] as List;
                  Map mediaItem =
                      media.firstWhere((element) => element['isImage'] == true)
                          as Map;
                  eventImage = mediaItem['url'];
                } catch (e) {
                  eventImage = '';
                }
                documentSnapshot['media'];

                Timestamp t = documentSnapshot['date'];
                DateTime d = t.toDate();

                final date = d;

                return eventView(
                  "${data.docs[index]['location']}",
                  "${data.docs[index]['event_name']}",
                  "${data.docs[index]['event']}",
                  "${data.docs[index]['description']}",
                  "${data.docs[index]['start_time']}",
                  "${data.docs[index]['end_time']}",
                  "${data.docs[index]['#_participants']}",
                  date,
                  eventImage,
                  snapshot.data!.docs[index].id,
                );
              }));
        });

    // ignore: avoid_unnecessary_containers, prefer_const_constructors
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
          leading: searching
              ? BackButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() => searching = false);
                  },
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  // ignore: unnecessary_string_escapes
                  child: Image.asset('assets/images/navi.png'),
                ),
          // ignore: prefer_const_literals_to_create_immutables
          actions: [
            // ignore: prefer_const_constructors
            Tooltip(
              message: "Create Event ",
              child: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => CreateEventView()));
                  },
                  icon: Icon(Icons.add_circle_outlined)),
            ),
          ],
          title: TextFormField(
            autofocus: false,
            decoration: InputDecoration(
              fillColor: Colors.grey[300],
              filled: true,
              hintText: ('Search Events'),
              // ignore: prefer_const_constructors
              contentPadding:
                  EdgeInsets.only(top: kToolbarHeight / 4, left: 10),
              // ignore: prefer_const_constructors
              suffixIcon: IconButton(
                // ignore: prefer_const_constructors
                icon: Icon(
                  Icons.search_rounded,
                  color: Colors.grey,
                ),
                onPressed: () {},
              ),
            ),
            onTap: () => setState(() => searching = true),
          )),
      body: Container(

          // ignore:
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('assets/images/backdrop.png'),
              fit: BoxFit.cover,
            ),
            gradient: LinearGradient(
              // ignore: prefer_const_literals_to_create_immutables
              colors: [Colors.white70, Colors.blue.shade100],
              // ignore: prefer_const_literals_to_create_immutables
              stops: [0, 1],
            ),
          ),
          child: displayEvents),
    );
  }
}

class eventdetails {
  final String location;

  final String event_name;
  final String event_type;
  final String description;
  final String start_time;
  final String end_time;
  final String participants;
  final DateTime date;
  final String image;
  final String id;

  eventdetails(
    this.location,
    this.event_name,
    this.event_type,
    this.description,
    this.start_time,
    this.end_time,
    this.participants,
    this.date,
    this.image,
    this.id,
  );
}
