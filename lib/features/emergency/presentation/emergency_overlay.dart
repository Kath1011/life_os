import 'package:flutter/material.dart';

class EmergencyOverlay extends StatelessWidget {
  const EmergencyOverlay({super.key, required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.74),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF8B1016),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFFF9DA0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'EMERGENCY MODE',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
              ),
              const SizedBox(height: 8),
              const Text(
                'Select a crisis type and follow zero-scroll action steps:',
              ),
              const SizedBox(height: 10),
              const Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _CrisisChip(label: 'Gas Leak'),
                  _CrisisChip(label: 'Fire'),
                  _CrisisChip(label: 'Flood'),
                  _CrisisChip(label: 'Electrical'),
                ],
              ),
              const SizedBox(height: 14),
              const Text(
                '1. Ensure immediate safety\n2. Isolate utility source\n3. Call emergency services if needed',
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF111111),
                  ),
                  onPressed: onClose,
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
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
