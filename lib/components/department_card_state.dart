import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DepartmentCardState {
  String description;
  List<String> requirements;

  DepartmentCardState({required this.description, required this.requirements});
}

class DepartmentCardStateNotifier extends StateNotifier<DepartmentCardState> {
  DepartmentCardStateNotifier()
      : super(DepartmentCardState(description: '', requirements: []));

  void updateDescription(String newDescription) {
    state = DepartmentCardState(
        description: newDescription, requirements: state.requirements);
  }

  void addRequirement() {
    state = DepartmentCardState(
        description: state.description,
        requirements: [...state.requirements, '']);
  }

  void removeRequirement() {
    if (state.requirements.length > 1) {
      state = DepartmentCardState(
          description: state.description,
          requirements: state.requirements..removeLast());
    }
  }

  void updateRequirement(int index, String value) {
    final updatedRequirements = List<String>.from(state.requirements);
    updatedRequirements[index] = value;

    state = DepartmentCardState(
        description: state.description, requirements: updatedRequirements);
  }
}

final departmentCardStateProvider =
    StateNotifierProvider<DepartmentCardStateNotifier, DepartmentCardState>(
        (ref) {
  return DepartmentCardStateNotifier();
});
