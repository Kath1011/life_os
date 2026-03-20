import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LifeOsTab { home, diagnostics, pantry, schedules, profile }

class LifeOsState {
  const LifeOsState({
    this.currentTab = LifeOsTab.home,
    this.emergencyMode = false,
    this.safetyAcknowledged = false,
    this.selectedIngredients = const <String>{},
  });

  final LifeOsTab currentTab;
  final bool emergencyMode;
  final bool safetyAcknowledged;
  final Set<String> selectedIngredients;

  LifeOsState copyWith({
    LifeOsTab? currentTab,
    bool? emergencyMode,
    bool? safetyAcknowledged,
    Set<String>? selectedIngredients,
  }) {
    return LifeOsState(
      currentTab: currentTab ?? this.currentTab,
      emergencyMode: emergencyMode ?? this.emergencyMode,
      safetyAcknowledged: safetyAcknowledged ?? this.safetyAcknowledged,
      selectedIngredients: selectedIngredients ?? this.selectedIngredients,
    );
  }
}

class LifeOsController extends Notifier<LifeOsState> {
  @override
  LifeOsState build() => const LifeOsState();

  void switchTab(LifeOsTab tab) {
    state = state.copyWith(currentTab: tab);
  }

  void toggleEmergencyMode() {
    state = state.copyWith(emergencyMode: !state.emergencyMode);
  }

  void setSafetyAcknowledged(bool value) {
    state = state.copyWith(safetyAcknowledged: value);
  }

  void toggleIngredient(String ingredient) {
    final updated = Set<String>.from(state.selectedIngredients);
    if (updated.contains(ingredient)) {
      updated.remove(ingredient);
    } else {
      updated.add(ingredient);
    }
    state = state.copyWith(selectedIngredients: updated);
  }
}

final lifeOsControllerProvider =
    NotifierProvider<LifeOsController, LifeOsState>(LifeOsController.new);
