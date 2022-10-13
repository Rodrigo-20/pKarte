import 'package:flutter/material.dart';

import 'etiqueta.dart';

class Filtro extends ChangeNotifier{
  final  List<Etiqueta> _etiquetas = [];

  List<Etiqueta> get etiquetas => _etiquetas;

  void add(Etiqueta etiqueta) {
    _etiquetas.add(etiqueta);
    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
    notifyListeners();
  }

  void remove(Etiqueta etiqueta){
    _etiquetas.remove(etiqueta);
    notifyListeners();
  }
}