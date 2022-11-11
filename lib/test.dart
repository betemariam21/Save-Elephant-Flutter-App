import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  final fb = FirebaseDatabase.instance;
  late Query ref1;
  late Query ref2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref1 = fb.ref().child('Contacts').orderByChild('name');

    ref2 = fb.ref().child('test');
  }

  Widget _buildContactItem({Map? contact}) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.person,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
          SizedBox(
            width: 6.0,
          ),
          Text(
            contact!["name"],
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test test"),
      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: ref1,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map? contact = snapshot.value as Map?;
            return _buildContactItem(contact: contact);
          },
        ),
      ),
    );
  }
}
