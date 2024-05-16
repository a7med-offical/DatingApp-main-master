import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _isSmartEnabled = false;

  void _toggleSmartFeature(bool value) {
    setState(() {
      _isSmartEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView(
        children: [
          ListTile(
            title:const Text('Notification Settings'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Handle notification settings tap
            },
          ),
          ListTile(
            title: Text('Account Settings'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Handle account settings tap
            },
          ),
          ListTile(
            title: Text('Privacy Settings'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Handle privacy settings tap
            },
          ),
          ListTile(
            title: Text('Smart Feature'),
            trailing: Switch(
              value: _isSmartEnabled,
              onChanged: _toggleSmartFeature,
            ),
          ),
          ListTile(
            title: Text('About'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Handle about tap
            },
          ),
        ],
      ),
    );
  }
}


