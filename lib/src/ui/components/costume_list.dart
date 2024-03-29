import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/label.dart';
import '../../models/filter.dart';

class CustomColorList extends StatelessWidget {
  List<Label>? list;
  //final Function(int,bool) toggle;
  final Function(Label,bool) toggle;
  CustomColorList({Key? key, required this.list, required this.toggle}) : super(key: key);

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
        itemCount:list!.length + 1
    );
  }

  _cell(Label item, int index,BuildContext context){
    var filter = context.watch<FilterModel>();
    return (
        SwitchListTile(
          title: Text(item.name!),
          value: filter.labels.contains(item),
          onChanged: (bool newValue){
             if(newValue){
               if(filter.labels.contains(item)==false){
                 filter.add(item);
               }
             }
             else {
               filter.remove(item);
             }
          } ,
        )
    );
  }
}
