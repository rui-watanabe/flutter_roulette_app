import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_roulette_app/model/pie_model.dart';

final PieModelProvider =
    StateNotifierProvider<PieModelList, List<PieModel>>((ref) {
  return PieModelList();
});

class PieModelList extends StateNotifier<List<PieModel>> {
  PieModelList() : super([]);

  void addPie(String name, Color color) {
    state = [...state, PieModel(name, color)];
  }

  // void editPie(int index, String newName) {
  //   state = [
  //     for (int i = 0; i < state.length; i++)
  //       if (i == index) PieModel(newName) else state[i]
  //   ];
  // }

  // void deletePie(int index) A{
  //   state = [
  //     for (int i = 0; i < state.length; i++)
  //       if (i != index) state[i]
  //   ];
  // }

  String getResultName(int index) {
    return index < state.length ? state[index].name : "";
  }

  void deleteAllPies() {
    state = [];
  }
}
