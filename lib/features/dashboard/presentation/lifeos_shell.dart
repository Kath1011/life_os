import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_os/features/diagnostics/presentation/diagnostics_tab.dart';
import 'package:life_os/features/emergency/presentation/emergency_overlay.dart';
import 'package:life_os/features/home/presentation/home_tab.dart';
import 'package:life_os/features/profile/presentation/profile_tab.dart';
import 'package:life_os/features/schedules/presentation/schedules_tab.dart';
import 'package:life_os/features/utilities/presentation/utilities_tab.dart';
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
      body: _BodyStack(state: state, controller: controller),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _BodyStack extends StatelessWidget {
  const _BodyStack({
    required this.state,
    required this.controller,
  });

  final LifeOsState state;
  final LifeOsController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IndexedStack(
          index: state.currentTab.index,
          children: [
            HomeTab(onEmergencyTap: controller.toggleEmergencyMode),
            DiagnosticsTab(
              isCeilingLeak: state.leakOrigin == LeakOrigin.fromCeiling,
              safetyAcknowledged: state.safetyAcknowledged,
              onLeakOriginChanged: (isCeiling) {
                controller.setLeakOrigin(
                  isCeiling ? LeakOrigin.fromCeiling : LeakOrigin.underSink,
                );
              },
              onSafetyChanged: controller.setSafetyAcknowledged,
            ),
            UtilitiesTab(
              selectedIngredients: state.selectedIngredients,
              onIngredientToggle: controller.toggleIngredient,
            ),
            const SchedulesTab(),
            const ProfileTab(),
          ],
        ),
        if (state.emergencyMode)
          EmergencyOverlay(onClose: controller.toggleEmergencyMode),
      ],
    );
  }
}
