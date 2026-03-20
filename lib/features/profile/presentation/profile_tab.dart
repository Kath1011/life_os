import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text('My Specs', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        ListTile(
          title: Text('Unit Type'),
          subtitle: Text('Apartment 4B'),
        ),
        ListTile(
          title: Text('Main Shutoff'),
          subtitle: Text('Kitchen cabinet, back-left valve'),
        ),
        ListTile(
          title: Text('Emergency Contact'),
          subtitle: Text('Building Admin: +63 900 000 0000'),
        ),
        SizedBox(height: 8),
        Text('Stored locally only, no cloud upload.'),
      ],
    );
  }
}
