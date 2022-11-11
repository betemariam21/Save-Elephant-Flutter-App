import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

import '../map_s.dart';
import 'languages_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () =>  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> map_s())),
        ),
        title:const Center(
        child:  Text('Save Elephants',style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
          fontFamily: 'Playfair Display',

        ),),
      ),
      ),
      body: buildSettingsList(),
    );
  }

  Widget buildSettingsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(

        padding: const EdgeInsets.only(top: 12.0),
        child: SettingsList(
          //lightBackgroundColor: Colors.,
          //backgroundColor: Colors.white70,
          sections: [
            SettingsSection(
              title: 'Common',
              tiles: [
                SettingsTile(
                  title: 'Language',
                  subtitle: 'English',
                  leading: const Icon(Icons.language),
                  onPressed: (context) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const LanguagesScreen(),
                    ));
                  },
                ),
                SettingsTile(
                  title: 'Environment',
                  subtitle: 'Testing',
                  leading: Icon(Icons.cloud_queue),
                ),
              ],
            ),
            SettingsSection(
              title: 'Account',
              tiles: [
                SettingsTile(title: '+251967259678 \n+251976044402', leading: Icon(Icons.phone)),
                SettingsTile(title: 'Maedin17@gmail.com', leading: Icon(Icons.email)),
              ],
            ),

            SettingsSection(
              title: 'Misc',
              tiles: [
                SettingsTile(
                    title: 'Terms of Service', leading: Icon(Icons.description)),
                SettingsTile(
                    title: 'Open source licenses',
                    leading: Icon(Icons.collections_bookmark)),
              ],
            ),
            CustomSection(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 22, bottom: 8),
                    child: Image.asset(
                      'images/save_2.png',
                      height: 250,
                      width: 250,

                    ),
                  ),
                  const Text(
                    'Version: 1.0.0',
                    style: TextStyle(color: Color(0xFF777777)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
