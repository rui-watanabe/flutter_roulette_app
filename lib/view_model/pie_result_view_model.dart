import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_roulette_app/model/pie_model.dart';

final PieResultModelProvider =
    StateNotifierProvider<PieResultViewModel, PieResultModel>((ref) {
  return PieResultViewModel();
});

class PieResultViewModel extends StateNotifier<PieResultModel> {
  PieResultViewModel() : super(PieResultModel(""));

  void setResultName(String name) {
    state = PieResultModel(name);
  }
}
