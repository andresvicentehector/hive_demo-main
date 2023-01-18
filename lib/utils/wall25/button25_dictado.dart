
import 'package:flutter/material.dart';
import 'package:flutter_color_picker_wheel/flutter_color_picker_wheel.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sunboards_vuit/template/utils/common.dart';

class Wall25ButtonDictado extends StatefulWidget {
  final int index;
  final Function sendMessage;


  const Wall25ButtonDictado({required this.index, required this.sendMessage});

  @override
  State<Wall25ButtonDictado> createState() => _Wall25ButtonDictadoState();
}

class _Wall25ButtonDictadoState extends State<Wall25ButtonDictado> {
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
      height:32.3,
      child: Container(
        decoration: BoxDecoration( borderRadius: BorderRadius.circular(18) ,border: Border.all(color: isActivated ? Colors.blue : Colors.transparent,)),
        child: GestureDetector(
          onTap: () =>{ _activate(),print("hey")}
          ,
          onDoubleTap: () => _unactivate(),

          //child: Text("${widget.index}")


        ),
      ),
    );
  }
}

// checkear si el index contains en la lista de strings ->  if (widget.presas.contains("$index"+",") )
