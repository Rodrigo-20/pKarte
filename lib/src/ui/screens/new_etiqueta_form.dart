import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pkarte/src/models/palette_enum.dart';
import 'package:pkarte/src/ui/screens_controllers/new_etiqueta_form_controller.dart';
import '../components/color_selector.dart';
import '../components/custom_button.dart';

class EtiquetaForm extends StatefulWidget {
  const EtiquetaForm({Key? key}) : super(key: key);

  @override
  _EtiquetaFormState createState() => _EtiquetaFormState();
}

class _EtiquetaFormState extends StateMVC {
  _EtiquetaFormState() :super(EtiquetaFormController()) {
    _con = EtiquetaFormController().con;
  }

  late EtiquetaFormController _con;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.initPage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etiqueta nueva'),
      ),
      body: Center(
          child: _form(),
      ),
    );
  }


  _form(){
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 50,),
              TextField(
                controller: _con.nameController,
                decoration:const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre',
                ),
              ),
              const SizedBox( height: 20,),
              TextField(
                controller: _con.descriptionController,
                decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Descripcion',
                ),
              ),
              const SizedBox(height: 20,),
              ExpansionTile(
                title: const Text('Selecciona un color'),
                children: [
                  ColorSelector(palette: PaletteColor.hueColors,onSelectColor: _con.selectColor,currentColor: _con.currentColor?? PaletteColor.blue)
                ],
              ),
              const SizedBox(height: 20,),
              CustomButton(
                backgroundColor: Colors.teal,
                textStyle: TextStyle(letterSpacing: 3),
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                text: 'Guardar',
                  onTap:(){
                    _con.addEtiqueta();
                    Navigator.pop(context);},
                  ),
            ],
          ),
        ),
      ),
    );
  }

}

