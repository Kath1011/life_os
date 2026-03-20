import 'package:flutter/material.dart';

class SchedulesTab extends StatelessWidget {
  const SchedulesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SwitchListTile(
          value: true,
          onChanged: (_) {},
          title: const Text('Local notifications'),
          subtitle: const Text('No internet needed'),
        ),
        const SizedBox(height: 8),
        const LinearProgressIndicator(value: 0.65),
        const SizedBox(height: 8),
        const Text('Monthly filter change checklist: 2 of 3 tasks complete.'),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('Add Schedule'),
        ),
      ],
    );
  }
}
