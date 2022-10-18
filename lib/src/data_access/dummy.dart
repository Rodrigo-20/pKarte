
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pkarte/src/interfaces/data_access.dart';
import 'package:pkarte/src/models/marker.dart';

import '../models/etiqueta.dart';
import '../models/palette_enum.dart';

class DummyData implements IDataAccess {

  DummyData();

  List<Etiqueta> getEtiquetas(){
    return [
      Etiqueta(name: 'restaurantes',color: PaletteColor.magenta, locations: [CustomLocation(id:'adelita',latitude: -24.843, longitud:-65.45, ) ]),
      Etiqueta(name: 'parques' ,color: PaletteColor.green, locations: [CustomLocation(id: 'plaza', longitud:-65.409003 , latitude: -24.797694)]),
      Etiqueta(name: 'museos')];
  }


  void saveEtiquetas(List<Etiqueta> etiquetas){

  }

  void addEtiqueta(Etiqueta etiqueta){

    //_controller.addEtiqueta(etiqueta);
  }


}