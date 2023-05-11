import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pkarte/src/managers/data_manager.dart';
import 'package:pkarte/src/models/color_item.dart';
import '../../models/label.dart';

class LabelFormController extends ControllerMVC {

  factory LabelFormController(){
    if (_instance == null) { _instance = LabelFormController._();}
    return _instance!;
  }
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    static LabelFormController? _instance;
    LabelFormController get con => _instance!;
    DataManager dataManager = DataManager.instance;
    List <TextEditingController> textControllers = [];
    ColorItem? currentColor;
    LabelFormController._();

    void initPage(){
      textControllers.add(nameController);
      textControllers.add(descriptionController);
      textControllers.forEach((element) {
        element.addListener(() {
          print(element.text);
        });
      });
    }

  void addLabel( ) {
    if(nameController.text.isNotEmpty){
    Label label = Label(name: nameController.text, description: descriptionController.text,color: currentColor!.name);
    dataManager.addLabel(label);
    nameController.text = "";
    descriptionController.text = "";
    }
  }

  void selectColor(ColorItem color){
    setState(() {
      currentColor = color;
    });
  }
}