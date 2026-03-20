import 'package:flutter/material.dart';

class OfflineBadge extends StatelessWidget {
  const OfflineBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2A37),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFF2AC3DE).withValues(alpha: 0.4)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cloud_off, size: 14, color: Color(0xFF8BD3E6)),
          SizedBox(width: 6),
          Text('Offline Ready', style: TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}
