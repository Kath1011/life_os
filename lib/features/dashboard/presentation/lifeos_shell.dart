import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:life_os/core/theme/emergency_theme.dart';
import 'package:life_os/features/diagnostics/presentation/diagnostics_tab.dart';
import 'package:life_os/features/emergency/presentation/emergency_screen.dart';
import 'package:life_os/features/home/presentation/home_tab.dart';
import 'package:life_os/features/profile/presentation/profile_tab.dart';
import 'package:life_os/features/schedules/presentation/schedules_tab.dart';
import 'package:life_os/features/utilities/presentation/utilities_tab.dart';
import 'package:life_os/services/lifeos_controller.dart';
import 'package:life_os/widgets/offline_badge.dart';

class LifeOsShell extends ConsumerStatefulWidget {
  const LifeOsShell({super.key});

  @override
  ConsumerState<LifeOsShell> createState() => _LifeOsShellState();
}

class _LifeOsShellState extends ConsumerState<LifeOsShell> {
  bool _emergencyRouteOpen = false;

  Future<void> _openEmergencyRoute() async {
    if (_emergencyRouteOpen || !mounted) {
      return;
    }

    _emergencyRouteOpen = true;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) {
          return Theme(
            data: emergencyTheme,
            child: EmergencyScreen(onExit: () => Navigator.of(context).pop()),
          );
        },
      ),
    );
    _emergencyRouteOpen = false;

    if (!mounted) {
      return;
    }

    final controller = ref.read(lifeOsControllerProvider.notifier);
    final isEmergency = ref.read(
      lifeOsControllerProvider.select((s) => s.isEmergencyMode),
    );
    if (isEmergency) {
      controller.toggleEmergencyMode();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(lifeOsControllerProvider.notifier);
    final currentTabIndex = ref.watch(
      lifeOsControllerProvider.select((s) => s.currentTabIndex),
    );
    final isEmergency = ref.watch(
      lifeOsControllerProvider.select((s) => s.isEmergencyMode),
    );

    ref.listen<bool>(
      lifeOsControllerProvider.select((s) => s.isEmergencyMode),
      (previous, next) {
        if (next) {
          _openEmergencyRoute();
        }
      },
    );

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 32,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'LifeOS',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        actions: const [
          Padding(padding: EdgeInsets.only(right: 10), child: OfflineBadge()),
        ],
      ),
      body: IndexedStack(
        index: currentTabIndex,
        children: [
          HomeTab(onEmergencyTap: controller.toggleEmergencyMode),
          const _DiagnosticsTabConnector(),
          const UtilitiesTab(),
          const SchedulesTab(),
          const ProfileTab(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF040B25),
        indicatorColor: const Color(0xFF0B1A3B),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        height: 66,
        selectedIndex: currentTabIndex,
        onDestinationSelected: (index) {
          controller.switchTab(index);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.route_outlined),
            label: 'Diagnostics',
          ),
          NavigationDestination(
            icon: Icon(Icons.kitchen_outlined),
            label: 'Pantry',
          ),
          NavigationDestination(
            icon: Icon(Icons.event_repeat_outlined),
            label: 'Schedules',
          ),
          NavigationDestination(
            icon: Icon(Icons.badge_outlined),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFE8383C),
        onPressed: controller.toggleEmergencyMode,
        icon: Icon(isEmergency ? Icons.close : Icons.warning_amber_rounded),
        label: Text(isEmergency ? 'EXIT' : 'EMERGENCY', style: const TextStyle(fontSize: 10)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class _DiagnosticsTabConnector extends ConsumerWidget {
  const _DiagnosticsTabConnector();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeNodeId = ref.watch(
      lifeOsControllerProvider.select((s) => s.activeDiagnosticNodeId),
    );
    final safetyAcknowledged = ref.watch(
      lifeOsControllerProvider.select((s) => s.safetyAcknowledged),
    );
    final controller = ref.read(lifeOsControllerProvider.notifier);

    return DiagnosticsTab(
      activeDiagnosticNodeId: activeNodeId,
      safetyAcknowledged: safetyAcknowledged,
      onNavigateNode: controller.navigateDiagnosticNode,
      onSafetyChanged: controller.setSafetyAcknowledged,
    );
  }
}
