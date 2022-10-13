import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pkarte/src/models/marker.dart';
import 'package:pkarte/src/models/palette_enum.dart';

import 'color_item.dart';

class Etiqueta{
  String? name;
  String? description;
  ColorItem? color;
  List<Marker>? markers = [];
  List<CostumeMarker> locations = [];
  bool? active;
  int id= _cantidad;
  static int _cantidad= 1;
  void _contar(){
    _cantidad++;
  }
  Etiqueta({required this.name,this.description, this.color, this.active=false, this.markers}) {
    color ??= PaletteColor.blue;
    _contar();
  }

  Etiqueta.fromJson(Map<String,dynamic> json)
      :name = json['name'],
        description = json['description']?? '',
        color = json['color'],
        active = json['active'];


  void addMarker(String name, double lati,double long)  {
    CostumeMarker marker = CostumeMarker(name: name, longitud: long, latitude: lati);

  }

  void setMarkers(List<Marker> markers){

  }

  void removeMarker(CostumeMarker marker){
    markers!.remove(marker);
  }
}