import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_os/services/lifeos_controller.dart';
import 'package:life_os/widgets/offline_badge.dart';

class LifeOsShell extends ConsumerWidget {
  const LifeOsShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(lifeOsControllerProvider);
    final controller = ref.read(lifeOsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('LifeOS', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: OfflineBadge(),
          ),
        ],
      ),
      body: IndexedStack(
        index: state.currentTab.index,
        children: [
          _HomeTab(onEmergencyTap: controller.toggleEmergencyMode),
          _DiagnosticsTab(
            safetyAcknowledged: state.safetyAcknowledged,
            onSafetyChanged: controller.setSafetyAcknowledged,
          ),
          _PantryTab(
            selectedIngredients: state.selectedIngredients,
            onIngredientToggle: controller.toggleIngredient,
          ),
          const _SchedulesTab(),
          const Center(child: Text('My Specs / Profile (local only)')),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: state.currentTab.index,
        onDestinationSelected: (index) {
          controller.switchTab(LifeOsTab.values[index]);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.route_outlined), label: 'Diagnostics'),
          NavigationDestination(icon: Icon(Icons.kitchen_outlined), label: 'Pantry'),
          NavigationDestination(icon: Icon(Icons.event_repeat_outlined), label: 'Schedules'),
          NavigationDestination(icon: Icon(Icons.badge_outlined), label: 'Profile'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFE8383C),
        onPressed: controller.toggleEmergencyMode,
        icon: const Icon(Icons.warning_amber_rounded),
        label: const Text('EMERGENCY'),
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab({required this.onEmergencyTap});

  final VoidCallback onEmergencyTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFE8383C),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Emergency Mode\nFast local-first action guides',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              IconButton(
                onPressed: onEmergencyTap,
                icon: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Core Modules',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        const Wrap(
          runSpacing: 10,
          spacing: 10,
          children: [
            _ModuleCard(title: 'Home Repairs', subtitle: 'Field Manual'),
            _ModuleCard(title: 'Diagnostics', subtitle: 'Decision Trees'),
            _ModuleCard(title: 'Survival Finance', subtitle: 'Household Ops'),
            _ModuleCard(title: 'Skill Builder', subtitle: 'Continue Learning'),
          ],
        ),
      ],
    );
  }
}

class _DiagnosticsTab extends StatelessWidget {
  const _DiagnosticsTab({
    required this.safetyAcknowledged,
    required this.onSafetyChanged,
  });

  final bool safetyAcknowledged;
  final ValueChanged<bool> onSafetyChanged;

  @override
  Widget build(BuildContext context) {
    final blocked = !safetyAcknowledged;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Leak Origin', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'sink', label: Text('Under sink')),
              ButtonSegment(value: 'ceiling', label: Text('From ceiling')),
            ],
            selected: const {'ceiling'},
            onSelectionChanged: (_) {},
          ),
          const SizedBox(height: 12),
          const Text(
            'Ceiling leak detected: stop DIY and call a licensed pro immediately.',
            style: TextStyle(color: Color(0xFFFF8F8F)),
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

class _PantryTab extends StatelessWidget {
  const _PantryTab({
    required this.selectedIngredients,
    required this.onIngredientToggle,
  });

  final Set<String> selectedIngredients;
  final ValueChanged<String> onIngredientToggle;

  @override
  Widget build(BuildContext context) {
    const ingredients = ['Rice', 'Beans', 'Tomato', 'Eggs', 'Chicken', 'Onion'];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Pantry Matcher', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ingredients.map((item) {
              final selected = selectedIngredients.contains(item);
              return FilterChip(
                selected: selected,
                label: Text(item),
                onSelected: (_) => onIngredientToggle(item),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.search),
            label: const Text('Find Matching Recipes'),
          ),
        ],
      ),
    );
  }
}

class _SchedulesTab extends StatelessWidget {
  const _SchedulesTab();

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

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 22,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF273142)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Color(0xFF9BA7B6)),
          ),
        ],
      ),
    );
  }
}
