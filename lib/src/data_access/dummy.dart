import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pkarte/src/interfaces/data_access.dart';

import '../models/etiqueta.dart';

class DummyData implements IDataAccess {

  DummyData();

  List<Etiqueta> getEtiquetas(){
    return [
      Etiqueta(name: 'restaurantes', markers: [Marker(markerId: MarkerId('adelita'),position: LatLng(-24.843,-65.45), icon: BitmapDescriptor.defaultMarkerWithHue(200.0)),]),
      Etiqueta(name: 'parques'),
      Etiqueta(name: 'museos')];
  }

  double hexToDouble(Color hexa){
    double value;
    int red = hexa.red;
    int green = hexa.green;
    int blue = hexa.blue;
    const int max = 255;
    switch(red){
      case max: {

      }
    }
    return 1.0;
  }

  void saveEtiquetas(List<Etiqueta> etiquetas){

  }

  void addEtiqueta(Etiqueta etiqueta){

    //_controller.addEtiqueta(etiqueta);
  }


}