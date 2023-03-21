import 'package:flutter/material.dart';

import 'label.dart';

class FilterModel extends ChangeNotifier{
  final  List<Label> _labels = [];

  List<Label> get labels => _labels;

  void add(Label label) {
    _labels.add(label);
    notifyListeners();
  }

  void remove(Label label){
    _labels.remove(label);
    notifyListeners();
  }

  bool contains(Label label){
    return _labels.contains(label);
  }
}