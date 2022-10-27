
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pkarte/src/interfaces/data_access.dart';
import 'package:pkarte/src/models/custom_image.dart';
import 'package:pkarte/src/models/marker.dart';

import '../models/etiqueta.dart';
import '../models/palette_enum.dart';

class DummyData implements IDataAccess {

  DummyData();

  List<Etiqueta> getEtiquetas(){
    return [
      Etiqueta(name: 'restaurantes',color: PaletteColor.magenta,images:
      [
        CustomImage(image: Image.asset('assets/images/dondavid.jpg'), latitude: -24.7854951, longitude:-65.4107569, id:'don david'),
        CustomImage(image: Image.asset('assets/images/casona.jpg'), latitude: -24.7878246, longitude: -65.4371075, id:'la casona'),
        CustomImage(image: Image.asset('assets/images/paseo.jpg'), latitude: -24.798289, longitude:-65.4076732, id:'el paseo de la familia'),
      ]

          , locations: [CustomLocation(id:'adelita',latitude: -24.843, longitud:-65.45, ) ]),
      //Etiqueta(name: 'parques' ,color: PaletteColor.green, locations: [CustomLocation(id: 'plaza', longitud:-65.409003 , latitude: -24.797694)]),
      Etiqueta(name: 'museos')];
  }


  void saveEtiquetas(List<Etiqueta> etiquetas){

  }

  void addEtiqueta(Etiqueta etiqueta){
    print('guardando etiqueta name: ${etiqueta.name}, descripcion: ${etiqueta.description}, color seleccionado: ${etiqueta.color!.color}');
    //_controller.addEtiqueta(etiqueta);
  }

  void removeEtiqueta(Etiqueta etiqueta){
    print('borrando etiqueta');
  }
}