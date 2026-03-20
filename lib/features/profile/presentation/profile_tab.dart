import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_os/services/lifeos_controller.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final specs = ref.watch(
      lifeOsControllerProvider.select((s) => s.specsProfile),
    );
    final controller = ref.read(lifeOsControllerProvider.notifier);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('My Specs', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        TextFormField(
          initialValue: specs['unitType'] ?? 'Apartment 4B',
          decoration: const InputDecoration(labelText: 'Unit Type'),
          onChanged: (value) => controller.updateSpec('unitType', value),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue:
              specs['mainShutoff'] ?? 'Kitchen cabinet, back-left valve',
          decoration: const InputDecoration(labelText: 'Main Shutoff'),
          onChanged: (value) => controller.updateSpec('mainShutoff', value),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue:
              specs['emergencyContact'] ?? 'Building Admin: +63 900 000 0000',
          decoration: const InputDecoration(labelText: 'Emergency Contact'),
          onChanged: (value) =>
              controller.updateSpec('emergencyContact', value),
        ),
        const SizedBox(height: 8),
        FilledButton.icon(
          onPressed: () async {
            await controller.saveSpecs();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Specs saved locally')),
              );
            }
          },
          icon: const Icon(Icons.save),
          label: const Text('Save My Specs'),
        ),
        const SizedBox(height: 8),
        const Text('Stored locally only, no cloud upload.'),
      ],
    );
  }
}
