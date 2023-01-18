
import 'package:flutter/material.dart';
import 'package:flutter_color_picker_wheel/flutter_color_picker_wheel.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sunboards_vuit/template/utils/common.dart';

class Wall15ButtonDictado extends StatefulWidget {
  final int index;
  final Function sendMessage;


  const Wall15ButtonDictado({required this.index, required this.sendMessage});

  @override
  State<Wall15ButtonDictado> createState() => _Wall15ButtonDictadoState();
}

class _Wall15ButtonDictadoState extends State<Wall15ButtonDictado> {
  bool isActivated = false;





  _activate() =>{
    widget.sendMessage("${widget.index}.255"),
  setState(() =>isActivated = true),
  } ;
  _unactivate() => {

  widget.sendMessage("${widget.index}.0"),
    setState(() =>{isActivated = false,
    })
  };


@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height:39,
      child: Container(
        decoration: BoxDecoration( borderRadius: BorderRadius.circular(18) ,border: Border.all(color: isActivated ? Colors.blue : Colors.transparent,)),
        child: GestureDetector(
          onTap: () =>{ _activate(),print("hey")}
          ,
          onDoubleTap: () => _unactivate(),



        ),
      ),
    );
  }
}

// checkear si el index contains en la lista de strings ->  if (widget.presas.contains("$index"+",") )
