import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pkarte/src/managers/data_manager.dart';
import 'package:pkarte/src/models/color_item.dart';
import '../../models/etiqueta.dart';

class EtiquetaFormController extends ControllerMVC {

  factory EtiquetaFormController(){
    if (_instance == null) { _instance = EtiquetaFormController._();}
    return _instance!;
  }
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    static EtiquetaFormController? _instance;
    DataManager dataBase = DataManager.data;
    EtiquetaFormController._();

    EtiquetaFormController get con => _instance!;
    List <TextEditingController> textControllers = [];
    ColorItem? currentColor;

    void initPage(){
      textControllers.add(nameController);
      textControllers.add(descriptionController);
      textControllers.forEach((element) {
        element.addListener(() {
          print(element.text);
        });
      });
    }

  void addEtiqueta( ) {
    if(nameController.text!= ""){
    Etiqueta etiqueta = Etiqueta(name: nameController.text, description: descriptionController.text,color: currentColor);
    dataBase.addEtiqueta(etiqueta);
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