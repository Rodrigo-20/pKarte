import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/etiqueta.dart';
import '../../models/filtro.dart';

class CostumeList extends StatelessWidget {
  List<Etiqueta>? list;
  final Function(int) toggle;
  CostumeList({Key? key, required this.list, required this.toggle}) : super(key: key);

@override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index){
          if(index == 0){
            return Container(
                alignment:Alignment.bottomLeft,
                padding: EdgeInsets.all(10),
                height: 100,
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black,width: 6)),
                ),
                child:const Text("Etiquetas",style: TextStyle(fontSize: 25),));
          }
          else {
            return _cell( list![index - 1], index -1,context);
          }
        },
        itemCount: list!.length + 1
    );
  }

  _cell(Etiqueta item, int index,BuildContext context){
    var filter = context.read<FilterModel>();
    return (
        SwitchListTile(
          title: Text(item.name!),
          value: item.active!,
          onChanged: (bool value){
             toggle(index);
             if(value){
               filter.add(item);
             }
             else {
               filter.remove(item);
             }
          } ,
        )
    );
  }
}