import 'package:flutter/material.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key, required this.onExit});

  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Mode'),
        leading: IconButton(icon: const Icon(Icons.close), onPressed: onExit),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'Select a crisis type and follow zero-scroll action steps:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _CrisisChip(label: 'Gas Leak'),
              _CrisisChip(label: 'Fire'),
              _CrisisChip(label: 'Flood'),
              _CrisisChip(label: 'Electrical'),
            ],
          ),
          SizedBox(height: 18),
          Text('1. Ensure immediate safety'),
          Text('2. Isolate utility source'),
          Text('3. Contact emergency services if there is active risk'),
        ],
      ),
    );
  }
}

class _CrisisChip extends StatelessWidget {
  const _CrisisChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFB51F2A),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label),
    );
  }
}
