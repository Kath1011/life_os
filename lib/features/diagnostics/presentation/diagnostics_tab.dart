import 'package:flutter/material.dart';

class DiagnosticsTab extends StatelessWidget {
  const DiagnosticsTab({
    super.key,
    required this.activeDiagnosticNodeId,
    required this.safetyAcknowledged,
    required this.onNavigateNode,
    required this.onSafetyChanged,
  });

  final String? activeDiagnosticNodeId;
  final bool safetyAcknowledged;
  final ValueChanged<String> onNavigateNode;
  final ValueChanged<bool> onSafetyChanged;

  static const String _underSinkNodeId = 'leak_under_sink';
  static const String _fromCeilingNodeId = 'leak_from_ceiling';

  @override
  Widget build(BuildContext context) {
    final nodeId = activeDiagnosticNodeId ?? _fromCeilingNodeId;
    final isCeilingLeak = nodeId == _fromCeilingNodeId;
    final blocked = isCeilingLeak || !safetyAcknowledged;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Leak Origin',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: false, label: Text('Under sink')),
              ButtonSegment(value: true, label: Text('From ceiling')),
            ],
            selected: {isCeilingLeak},
            onSelectionChanged: (selection) {
              onNavigateNode(
                selection.first ? _fromCeilingNodeId : _underSinkNodeId,
              );
            },
          ),
          const SizedBox(height: 12),
          Text(
            isCeilingLeak
                ? 'Ceiling leak detected: stop DIY and call a licensed pro immediately.'
                : 'Sink-level issue: continue guided DIY checks if safety prerequisites are complete.',
            style: TextStyle(
              color: isCeilingLeak
                  ? const Color(0xFFFF8F8F)
                  : const Color(0xFF9CD6A8),
            ),
          ),
          CheckboxListTile(
            value: safetyAcknowledged,
            onChanged: (v) => onSafetyChanged(v ?? false),
            title: const Text('I confirmed power/water shutoff safety steps'),
          ),
          const SizedBox(height: 8),
          Opacity(
            opacity: blocked ? 0.35 : 1,
            child: IgnorePointer(
              ignoring: blocked,
              child: FilledButton(
                onPressed: () {},
                child: const Text('Open Repair Steps'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
