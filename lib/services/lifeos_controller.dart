import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_os/services/recipe_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const int homeTabIndex = 0;
const int diagnosticsTabIndex = 1;
const int pantryTabIndex = 2;
const int schedulesTabIndex = 3;
const int profileTabIndex = 4;

@immutable
class LifeOsState {
  const LifeOsState({
    this.currentTabIndex = homeTabIndex,
    this.isEmergencyMode = false,
    this.safetyAcknowledged = false,
    this.activeDiagnosticNodeId,
    this.selectedIngredients = const <String>{},
    this.specsProfile = const <String, String>{},
  });

  final int currentTabIndex;
  final bool isEmergencyMode;
  final bool safetyAcknowledged;
  final String? activeDiagnosticNodeId;
  final Set<String> selectedIngredients;
  final Map<String, String> specsProfile;

  LifeOsState copyWith({
    int? currentTabIndex,
    bool? isEmergencyMode,
    bool? safetyAcknowledged,
    Object? activeDiagnosticNodeId = _copySentinel,
    Set<String>? selectedIngredients,
    Map<String, String>? specsProfile,
  }) {
    return LifeOsState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      isEmergencyMode: isEmergencyMode ?? this.isEmergencyMode,
      safetyAcknowledged: safetyAcknowledged ?? this.safetyAcknowledged,
      activeDiagnosticNodeId: activeDiagnosticNodeId == _copySentinel
          ? this.activeDiagnosticNodeId
          : activeDiagnosticNodeId as String?,
      selectedIngredients: selectedIngredients ?? this.selectedIngredients,
      specsProfile: specsProfile ?? this.specsProfile,
    );
  }
}

const Object _copySentinel = Object();

class LifeOsController extends Notifier<LifeOsState> {
  bool _isLoadingSpecs = false;

  @override
  LifeOsState build() {
    if (!_isLoadingSpecs) {
      _isLoadingSpecs = true;
      unawaited(_loadSpecs());
    }
    return const LifeOsState();
  }

  void switchTab(int index) {
    final leavingDiagnostics =
        state.currentTabIndex == diagnosticsTabIndex &&
        index != diagnosticsTabIndex;

    state = state.copyWith(
      currentTabIndex: index,
      activeDiagnosticNodeId: leavingDiagnostics
          ? null
          : state.activeDiagnosticNodeId,
      safetyAcknowledged: leavingDiagnostics ? false : state.safetyAcknowledged,
    );
  }

  void toggleEmergencyMode() {
    state = state.copyWith(isEmergencyMode: !state.isEmergencyMode);
  }

  void setSafetyAcknowledged(bool value) {
    state = state.copyWith(safetyAcknowledged: value);
  }

  void navigateDiagnosticNode(String nodeId) {
    state = state.copyWith(
      activeDiagnosticNodeId: nodeId,
      safetyAcknowledged: false,
    );
  }

  void toggleIngredient(String ingredientId) {
    final updated = Set<String>.from(state.selectedIngredients);
    if (updated.contains(ingredientId)) {
      updated.remove(ingredientId);
    } else {
      updated.add(ingredientId);
    }
    state = state.copyWith(selectedIngredients: updated);
  }

  void updateSpec(String key, String value) {
    final updatedProfile = Map<String, String>.from(state.specsProfile);
    updatedProfile[key] = value;
    state = state.copyWith(specsProfile: updatedProfile);
  }

  Future<void> saveSpecs() async {
    final prefs = await SharedPreferences.getInstance();
    for (final entry in state.specsProfile.entries) {
      await prefs.setString(_specKey(entry.key), entry.value);
    }
  }

  Future<void> _loadSpecs() async {
    final prefs = await SharedPreferences.getInstance();
    const keys = <String>['unitType', 'mainShutoff', 'emergencyContact'];
    final profile = <String, String>{};

    for (final key in keys) {
      final value = prefs.getString(_specKey(key));
      if (value != null && value.isNotEmpty) {
        profile[key] = value;
      }
    }

    if (profile.isNotEmpty) {
      state = state.copyWith(specsProfile: profile);
    }
  }

  String _specKey(String field) => 'specs.$field';
}

final lifeOsControllerProvider =
    NotifierProvider<LifeOsController, LifeOsState>(LifeOsController.new);

final matchedRecipesProvider = Provider<List<Recipe>>((ref) {
  final ingredients = ref.watch(
    lifeOsControllerProvider.select((s) => s.selectedIngredients),
  );
  final repo = ref.read(recipeRepositoryProvider);
  return repo.match(ingredients);
});
