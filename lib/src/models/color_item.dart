import 'dart:ui';

class ColorItem{
  String name;
  Color color;
  double hueColor;
  bool active;
  ColorItem({required this.color, required this.name,required this.hueColor, this.active=false});
}