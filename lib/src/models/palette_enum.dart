import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pkarte/src/models/color_item.dart';

class PaletteColor {
  PaletteColor._();

  static List<ColorItem> hueColors =  [
    ColorItem(name:'cyan',color: Colors.cyan, hueColor:BitmapDescriptor.hueCyan ),
    ColorItem(name:'azure',color: const  Color(0xff007fff), hueColor:BitmapDescriptor.hueAzure ),
    ColorItem(name:'blue',color: Colors.blue, hueColor:BitmapDescriptor.hueBlue ),
    ColorItem(name:'green',color: Colors.green, hueColor:BitmapDescriptor.hueGreen ),
    ColorItem(name:'magenta',color: const Color(0xFFF50087), hueColor:BitmapDescriptor.hueMagenta ),
    ColorItem(name:'orange',color: Colors.orangeAccent, hueColor:BitmapDescriptor.hueOrange ),
    ColorItem(name:'red',color: Colors.redAccent, hueColor:BitmapDescriptor.hueRed ),
    ColorItem(name:'rose',color: const Color(0xFFDA8695), hueColor:BitmapDescriptor.hueRose ),
    ColorItem(name:'violet',color: const Color(0xFFBF40BF), hueColor:BitmapDescriptor.hueViolet ),
    ColorItem(name:'yellow',color: Colors.yellowAccent, hueColor:BitmapDescriptor.hueYellow ),
  ];

  static ColorItem blue =  ColorItem(name:'blue', color: Colors.blue, hueColor:BitmapDescriptor.hueBlue);
  static ColorItem cyan = ColorItem(name:'cyan',color: Colors.cyan, hueColor:BitmapDescriptor.hueCyan);
  static ColorItem green = ColorItem(name:'green', color: Colors.green, hueColor:BitmapDescriptor.hueGreen);
  static ColorItem rose = ColorItem(name:'rose',color: const Color(0xFFDA8695), hueColor:BitmapDescriptor.hueRose);
  static ColorItem magenta = ColorItem(name:'magenta',color: const Color(0xFFF50087), hueColor:BitmapDescriptor.hueMagenta);


}
