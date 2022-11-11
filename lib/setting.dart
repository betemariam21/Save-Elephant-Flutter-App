import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'screens/settings_screen.dart';

class setting extends StatelessWidget {
  const setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Save Elephants',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        brightness: Brightness.light,
      ),
      // darkTheme: ThemeData(
      //   colorScheme: ColorScheme.fromSwatch(
      //     primarySwatch: Colors.deepPurple,
      //     brightness: Brightness.dark,
      //   ).copyWith(secondary: Colors.deepPurple),
      // ),
      home: const SettingsScreen(),
    );
  }
}