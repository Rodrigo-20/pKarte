import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pkarte/src/models/label.dart';
import 'package:pkarte/src/ui/components/custom_button.dart';
import 'package:provider/provider.dart';
import '../../models/filter.dart';
import '../../models/palette_enum.dart';


class FilterComponent extends StatefulWidget {
  final Color color;
  final List<Label>? items;
  final Function(List<int>)? onTap;
  const FilterComponent(
      {Key? key, this.color = Colors.cyan, this.items, this.onTap})
      : super(key: key);

  @override
  State<FilterComponent> createState() => _FilterComponentState();
}

class _FilterComponentState extends State<FilterComponent> {
  ScrollController scrollController = ScrollController();
  List<int> actives = [];
  void getActiveFilters() {
    widget.items!.forEach((element) {
      if (element.isActive) {
        actives.add(element.id!);
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
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(bottom: 25),
      actions: [
        CustomButton(
          backgroundColor: widget.color,
          text: 'Aceptar',
          //padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
          onTap: () {
            getActiveFilters();
            widget.onTap!(actives);
            Navigator.pop(context);
          },
        ),
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
          'Filtros',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                  backgroundColor:getColorByName(item.color),
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
                  }
                ),
          ],
        ),
      ),
    );
  }
  
  Color? getColorByName(String colorName){
    return PaletteColor.hueColors.singleWhere((element) => element.name == colorName,orElse: ()=>PaletteColor.magenta).color;
  }
  
  double? getHueColorByName(String colorName){
    return PaletteColor.hueColors.singleWhere((element) => element.name == colorName,orElse: ()=>PaletteColor.magenta).hueColor;
  }

}
