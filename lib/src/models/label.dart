import 'package:pkarte/src/models/custom_image.dart';
import 'package:pkarte/src/models/palette_enum.dart';
import 'color_item.dart';

class Label{
  int? id;
  String name;
  String? description;
  String color;
  List<CustomImage>? images = [];
  bool isActive;

  Label({required this.name,this.description,this.id, this.color='green', this.isActive=false, this.images});

  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'name':name,
      'description':description,
      'color':color
    };
  }

  Label.fromMap(Map<String,dynamic> data)
      : id=data['id'],
        name = data['name'],
        description = data['description']?? '',
        color = data['color'],
        isActive = false;

  void changeState(bool value){
    isActive = value;
  }


}