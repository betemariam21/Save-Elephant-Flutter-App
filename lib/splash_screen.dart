import 'dart:async';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({Key? key}) : super(key: key);

  @override
  _splash_screenState createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>login())));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
          colors: [
            //Color(0xFF70A75D),
            Color(0xFF33ff33),
            Color(0xFF99ff99),


          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Image.asset(
                'images/AntiPoaching_2.png',
                height: 150.0,
                width: 300.0,
              ),
              const Text(
                'Save Elephants',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  fontFamily: 'Playfair Display',
                  decoration: TextDecoration.none,
                  //decorationStyle: TextDecorationStyle.values
                ),
              ),
            ],
          ),
          const CircularProgressIndicator(
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
