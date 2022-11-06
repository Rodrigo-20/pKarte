import 'package:flutter/widgets.dart';
import 'package:pkarte/src/interfaces/data_access.dart';
import 'package:pkarte/src/models/custom_image.dart';
import '../models/label.dart';
import '../models/palette_enum.dart';

class DummyData implements IDataAccess {

  DummyData();

  List<Label> getEtiquetas(){
    return [
      Label(name: 'restaurantes',color: PaletteColor.magenta,images:
      [
        CustomImage(image: Image.asset('assets/images/dondavid.jpg'), latitude: -24.7854951, longitude:-65.4107569, id:'don david'),
        CustomImage(image: Image.asset('assets/images/casona.jpg'), latitude: -24.7878246, longitude: -65.4371075, id:'la casona'),
        CustomImage(image: Image.asset('assets/images/paseo.jpg'), latitude: -24.798289, longitude:-65.4076732, id:'el paseo de la familia'),
      ], ),
      Label(name: 'parques', color: PaletteColor.green, images: [
        CustomImage(image: Image.asset('assets/images/parquesur.jpeg'), latitude: -24.8488434, longitude: -65.4385521, id: 'parque sur')
    ])
    ];
  }


  void saveEtiquetas(List<Label> etiquetas){

  }

  void addEtiqueta(Label etiqueta){
    print('guardando etiqueta name: ${etiqueta.name}, descripcion: ${etiqueta.description}, color seleccionado: ${etiqueta.color!.color}');
    //_controller.addEtiqueta(etiqueta);
  }

  void removeEtiqueta(Label etiqueta){
    print('borrando etiqueta');
  }
}