import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pkarte/src/models/marker.dart';
import 'package:pkarte/src/models/palette_enum.dart';

import 'color_item.dart';

class Etiqueta{
  String? name;
  String? description;
  ColorItem? color;
  List<Marker>? _markers = [];
  List<CustomLocation>? locations = [];
  bool? active;
  int id= _cantidad;
  static int _cantidad= 1;
  void _contar(){
    _cantidad++;
  }
  Etiqueta({required this.name,this.description, this.color, this.active=false, this.locations}) {
    color ??= PaletteColor.blue;
    _contar();
  }

  Etiqueta.fromJson(Map<String,dynamic> json)
      :name = json['name'],
        description = json['description']?? '',
        color = json['color'],
        active = json['active'];


  void addMarker(String name, double lati,double long)  {
    CustomLocation marker = CustomLocation(id: name, longitud: long, latitude: lati);

  }

  List<Marker> getMarkers(){
    if(locations!= null) {
      locations!.forEach((element) {
        _markers!.add(Marker(
            markerId: MarkerId(element.id),
            position: LatLng(element.latitude, element.longitud),
            icon: BitmapDescriptor.defaultMarkerWithHue(color!.hueColor),
        ));
      });
      return _markers!;
    }
    else {
      return [];
    }
  }


  void removeMarker(Marker marker){
    _markers!.remove(marker);
  }
}