import 'package:flutter/material.dart';

import 'etiqueta.dart';

class FilterModel extends ChangeNotifier{
  final  List<Etiqueta> _etiquetas = [];

  List<Etiqueta> get etiquetas => _etiquetas;

  void add(Etiqueta etiqueta) {
    _etiquetas.add(etiqueta);
    notifyListeners();
  }

  void remove(Etiqueta etiqueta){
    _etiquetas.remove(etiqueta);
    notifyListeners();
  }

  bool contains(Etiqueta etiqueta){
    return _etiquetas.contains(etiqueta);
  }
}