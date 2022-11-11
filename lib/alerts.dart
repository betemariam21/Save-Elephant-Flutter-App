import 'package:flutter/material.dart';
import 'package:save_elephants/alert_card.dart';
import 'map_s.dart';
import 'map_s.dart';

class alerts extends StatelessWidget {
  final List _stress = ['stress_1'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[300],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () =>  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> map_s())),
        ),
        title: Center(child: const Text('Alerts Received',
          style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
          fontFamily: 'Playfair Display',
        ),
        )),
          backgroundColor: Colors.lightGreen[300],
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _stress.length,
        itemBuilder: (context,index){
          return alert_card();
        }
      ),
    );

  }
}
