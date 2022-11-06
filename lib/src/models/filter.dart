import 'package:flutter/material.dart';

import 'label.dart';

class FilterModel extends ChangeNotifier{
  final  List<Label> _etiquetas = [];

  List<Label> get etiquetas => _etiquetas;

  void add(Label etiqueta) {
    _etiquetas.add(etiqueta);
    notifyListeners();
  }

  void remove(Label etiqueta){
    _etiquetas.remove(etiqueta);
    notifyListeners();
  }

  bool contains(Label etiqueta){
    return _etiquetas.contains(etiqueta);
  }
}