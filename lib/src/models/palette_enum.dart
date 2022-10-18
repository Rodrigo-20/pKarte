import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pkarte/src/models/color_item.dart';

class PaletteColor {
  PaletteColor._();

  static List<ColorItem> hueColors =  [
    ColorItem(color: Colors.cyan, hueColor:BitmapDescriptor.hueCyan ),
    ColorItem(color: const  Color(0xff007fff), hueColor:BitmapDescriptor.hueAzure ),
    ColorItem(color: Colors.blue, hueColor:BitmapDescriptor.hueBlue ),
    ColorItem(color: Colors.green, hueColor:BitmapDescriptor.hueGreen ),
    ColorItem(color: const Color(0xFFF50087), hueColor:BitmapDescriptor.hueMagenta ),
    ColorItem(color: Colors.orangeAccent, hueColor:BitmapDescriptor.hueOrange ),
    ColorItem(color: Colors.redAccent, hueColor:BitmapDescriptor.hueRed ),
    ColorItem(color: const Color(0xFFDA8695), hueColor:BitmapDescriptor.hueRose ),
    ColorItem(color: const Color(0xFFBF40BF), hueColor:BitmapDescriptor.hueViolet ),
    ColorItem(color: Colors.yellowAccent, hueColor:BitmapDescriptor.hueYellow ),
  ];

  static ColorItem blue =  ColorItem(color: Colors.blue, hueColor:BitmapDescriptor.hueBlue);
  static ColorItem cyan = ColorItem(color: Colors.cyan, hueColor:BitmapDescriptor.hueCyan);
  static ColorItem green = ColorItem(color: Colors.green, hueColor:BitmapDescriptor.hueGreen);
  static ColorItem rose = ColorItem(color: const Color(0xFFDA8695), hueColor:BitmapDescriptor.hueRose);
  static ColorItem magenta = ColorItem(color: const Color(0xFFF50087), hueColor:BitmapDescriptor.hueMagenta);

  static List<Color> brilloso = [Colors.redAccent,Colors.lightBlue,Color(0xb00f2c20),Color(0xff269612),Color(0xfd0fd096),Color(0xb00f2c20),Colors.redAccent,Colors.lightBlue,Color(0xb00f2c20),Colors.limeAccent];
  static List<Color> opaco = [Colors.lightGreen,Color(0xfd0fd096),Color(0xb00f2c20),Colors.orangeAccent,Colors.brown,Colors.indigo,Colors.lightGreen,Color(0xfd0fd096),Color(0xb00f2c20),Colors.orangeAccent,Colors.brown,Colors.indigo];

}
