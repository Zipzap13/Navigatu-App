import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/assets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // ignore: prefer_const_constructors
              _ProfileDetails(),
              // ignore: prefer_const_constructors
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 20,
                  bottom: 20,
                ),
                // ignore: prefer_const_constructors
                child: Text(
                  'Account',
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.black87,
                  ),
                ),
              ),
              // ignore: prefer_const_constructors
              ListTile(
                title: Text('Account  Information'),
                subtitle: Text('Your Personal Information'),
                trailing: Icon(
                  Icons.arrow_forward_rounded,
                ),
                onTap: () {},
              ),
              // ignore: prefer_const_constructors
              Divider(),
              ListTile(
                title: Text('Account  Information'),
                subtitle: Text('Your Personal Information'),
                trailing: Icon(
                  Icons.arrow_forward_rounded,
                ),
                onTap: () {},
              ),
              // ignore: prefer_const_constructors
              Divider(),
              ListTile(
                title: Text('Account  Information'),
                subtitle: Text('Your Personal Information'),
                trailing: Icon(
                  Icons.arrow_forward_rounded,
                ),
                onTap: () {},
              ),
              // ignore: prefer_const_constructors
              Divider(),
              ListTile(
                title: Text('Account  Information'),
                subtitle: Text('Your Personal Information'),
                trailing: Icon(
                  Icons.arrow_forward_rounded,
                ),
                onTap: () {},
              ),
              // ignore: prefer_const_constructors
              Divider(),
              ListTile(
                title: Text('Account  Information'),
                subtitle: Text('Your Personal Information'),
                trailing: Icon(
                  Icons.arrow_forward_rounded,
                ),
                onTap: () {
                  Text('hello');
                },
              ),
              ListTile(
                title: Text('Account  Information'),
                subtitle: Text('Your Personal Information'),
                trailing: Icon(
                  Icons.arrow_forward_rounded,
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileDetails extends StatelessWidget {
  const _ProfileDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        // ignore: prefer_const_constructors
        gradient: LinearGradient(
          // ignore: prefer_const_literals_to_create_immutables
          colors: [Colors.blue, Colors.indigo],
          // ignore: prefer_const_literals_to_create_immutables
          stops: [0, 1],
        ),
        // ignore: prefer_const_constructors
        borderRadius: BorderRadius.all(
            // ignore: prefer_const_constructors
            Radius.circular(10)),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        Assets.avat1logo,
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                      ),
                    ),
                    // ignore: prefer_const_constructors
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        // ignore: prefer_const_constructors
                        Text(
                          'Pablo Escobar',
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        // ignore: prefer_const_constructors
                        Text(
                          'pablo1@gmail.com',
                          // ignore: prefer_const_constructors
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Container(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                  color: Colors.blue,
                  // ignore: prefer_const_constructors
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  Icon(
                    Icons.verified_rounded,
                    color: Colors.white,
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    width: 7,
                  ),
                  // ignore: prefer_const_constructors
                  Text(
                    'Verified',
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
