import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pkarte/src/models/palette_enum.dart';

import '../../models/color_item.dart';


class ColorSelector extends StatelessWidget {
  final Function(ColorItem) onSelectColor;
  final List<ColorItem> palette;
  final ColorItem currentColor;
  const ColorSelector({Key? key,required this.palette,required this.currentColor, required this.onSelectColor}) : super(key: key);

  bool showTick(ColorItem item){
    return item  == currentColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 100,
            margin: const EdgeInsets.all(20),
            child: ListView.separated(
              itemBuilder: (context,index) => _cell( palette[index]),
              separatorBuilder: (context, index) => SizedBox(width: 20,),
              itemCount: palette.length,
              scrollDirection: Axis.horizontal,
              ),
            ),
          ]
        )
    );
  }

  _cell(ColorItem item){
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.0),
      child: InkWell(
        onTap: (){ onSelectColor(item);},
        child: Container(
            width: 100,
            color: item.color,
            child:AnimatedOpacity(
              opacity: showTick(item) ? 1.0: 0.0,
              duration:const Duration(milliseconds: 250),
              child: const Icon(Icons.check,size:40,color: Colors.white,),
            )
        ),
      ),
    );
  }

}


class ColorCircle extends StatefulWidget {
  final Color color;
  const ColorCircle({Key? key, required this.color}) : super(key: key);

  @override
  State<ColorCircle> createState() => _ColorCircleState();
}


class _ColorCircleState extends State<ColorCircle> {
  bool isShowTick = false;

  void showTick(){
    setState(() {
      isShowTick = !isShowTick ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.0),
      child: InkWell(
        onTap: showTick,
        child: Container(
          width: 100,
          color:widget.color,
          child:isShowTick ? const Icon(Icons.check,size:40,color: Colors.white,) : null,
        ),
      ),
    );;
  }
}

