import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pkarte/src/models/label.dart';
import 'package:pkarte/src/ui/components/custom_button.dart';
import 'package:provider/provider.dart';

import '../../models/filter.dart';
import '../screens/new_etiqueta_form.dart';


class AddPicFilter extends StatefulWidget {
  final Color color;
  final List<Label>? items;
  final Function(List<int>)? onTap;
  const AddPicFilter(
      {Key? key, this.color = Colors.cyan, this.items, this.onTap})
      : super(key: key);

  @override
  State<AddPicFilter> createState() => _AddPicFilterState();
}

class _AddPicFilterState extends State<AddPicFilter> {
  ScrollController scrollController = ScrollController();
  List<int> actives = [];
  void getActiveFilters() {
    widget.items!.forEach((element) {
      if (element.isActive) {
        actives.add(element.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _alertDialogCustom( );
  }

  _alertDialogCustom( ) {
    return AlertDialog(
      title: _header(),
      titlePadding: const EdgeInsets.symmetric(horizontal: 35),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      icon: _buttonClose(),
      iconPadding: const EdgeInsets.only(top: 8, right: 8),
      content:
      SizedBox(
        height:450,
        width: 300,
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return _listFilter(setState,context);
            }),

      ),
      contentPadding: const EdgeInsets.all(15),
      actionsAlignment: MainAxisAlignment.spaceAround,
      //actionsAlignment: MainAxisAlignment.center,
      actionsOverflowDirection: VerticalDirection.up,
      actionsPadding: const EdgeInsets.only(bottom: 25),

      actions: [
        Column(
          children: [
            CustomButton(
              backgroundColor: widget.color,
              text: 'Tomar Foto',
              //padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              onTap: () {
                getActiveFilters();
                widget.onTap!(actives);
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              backgroundColor:widget.color ,
              text: 'Agregar Filtro',

              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => const EtiquetaForm()));
              },
            )
          ],
        )
      ],
    );
  }

  _buttonClose() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [CloseButton()],
    );
  }

  _header() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      child: const Padding(
        padding: EdgeInsets.only(bottom: 12.0),
        child: Text(
          'Etiquetas',
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18, letterSpacing: 1),
        ),
      ),
    );
  }

  _listFilter(StateSetter setState,BuildContext context) {
    return RawScrollbar(
        controller: scrollController,
        thumbVisibility: true,
        thickness: 5,
        thumbColor: widget.color,
        trackVisibility: true,
        trackColor: Colors.grey,
        trackRadius: const Radius.circular(5),
        radius: const Radius.circular(5),
        child: Theme(
          data: ThemeData(
              scrollbarTheme: const ScrollbarThemeData(
                thickness: MaterialStatePropertyAll(5),
              )),
          child: ListView.builder(
              controller: scrollController,
              itemBuilder: (context, index) =>
                  _cellFilter(widget.items![index], setState, context),
              itemCount: widget.items!.length),
        ));
  }

  _cellFilter(Label item, StateSetter setState,BuildContext context) {
    var filter = context.watch<FilterModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Container(
        padding: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: item.color!.color,
                  child: const Icon(
                    Icons.location_on,
                    size: 23,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  item.name!,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            CupertinoSwitch(
                activeColor: widget.color,
                value: filter.etiquetas.contains(item),
                onChanged: (bool newValue){
                  if(newValue){
                    if(filter.etiquetas.contains(item)==false){
                      filter.add(item);
                    }
                  }
                  else {
                    filter.remove(item);
                  }
                }
            ),
          ],
        ),
      ),
    );
  }
}
