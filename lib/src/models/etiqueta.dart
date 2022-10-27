import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pkarte/src/models/custom_image.dart';
import 'package:pkarte/src/models/marker.dart';
import 'package:pkarte/src/models/palette_enum.dart';

import 'color_item.dart';

class Etiqueta{
  String? name;
  String? description;
  ColorItem? color;
  List<Marker>? _markers = [];
  List<CustomImage>? images = [];
  List<CustomLocation>? locations = [];
  bool isActive;
  int id= _cantidad;
  static int _cantidad= 1;
  void _contar(){
    _cantidad++;
  }
  Etiqueta({required this.name,this.description, this.color, this.isActive=false, this.locations, this.images}) {
    color ??= PaletteColor.blue;
    _contar();
  }

  Etiqueta.fromJson(Map<String,dynamic> json)
      :name = json['name'],
        description = json['description']?? '',
        color = json['color'],
        isActive = json['active'];

  void changeState(bool value){
    isActive = value;
  }

  void addMarker(String name, double lati,double long)  {
    CustomLocation marker = CustomLocation(id: name, longitud: long, latitude: lati);
  }

  void removeMarker(Marker marker){
    _markers!.remove(marker);
  }
}