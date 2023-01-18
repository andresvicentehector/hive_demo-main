import 'package:flutter/material.dart';
import 'package:sunboards_vuit/utils/wall15/button15_add.dart';

const List<int> UNUSED_BUTTONS = [14,15,30,31,46,47,62,63,79,95,111,127,143,335,348,349,350,351,359,360,361,362,363,364,365,366,367,372,373,374,375,376,377,378,379,380,381,382,383];
const List<String> num15 =["x", "x", "x", "x", "x", "x", "x", "x", "x", "131", "162", "163", "194", "195", "226", "227", "258", "259", "290", "291", "x", "x", "x", "x", "x", "x", "x", "x", "70", "71", "100", "101", "130", "132", "161", "164", "193", "196", "225", "228", "257", "260", "289", "292", "321", "x", "x", "x", "13", "14", "41", "42", "69", "72", "99", "102", "129", "133", "160", "165", "192", "197", "224", "229", "256", "261", "288", "293", "320", "x", "x", "x", "12", "15", "40", "43", "68", "73", "98", "103", "128", "134", "159", "166", "191", "198", "223", "230", "255", "262", "287", "294", "319", "x", "x", "x", "11", "16", "39", "44", "67", "74", "97", "104", "127", "135", "158", "167", "190", "199", "222", "231", "254", "263", "286", "295", "318", "322", "x", "x", "10", "17", "38", "45", "66", "75", "96", "105", "126", "136", "157", "168", "189", "200", "221", "232", "253", "264", "285", "296", "317", "323", "x", "x", "9", "18", "37", "46", "65", "76", "95", "106", "125", "137", "156", "169", "188", "201", "220", "233", "252", "265", "284", "297", "316", "324", "x", "x", "8", "19", "36", "47", "64", "77", "94", "107", "124", "138", "155", "170", "187", "202", "219", "234", "251", "266", "283", "298", "315", "325", "x", "x", "7", "20", "35", "48", "63", "78", "93", "108", "123", "139", "154", "171", "186", "203", "218", "235", "250", "267", "282", "299", "314", "326", "x", "x", "6", "21", "34", "49", "62", "79", "92", "109", "122", "140", "153", "172", "185", "204", "217", "236", "249", "268", "281", "300", "313", "327", "340", "x", "5", "22", "33", "50", "61", "80", "91", "110", "121", "141", "152", "173", "184", "205", "216", "237", "248", "269", "280", "301", "312", "328", "339", "x", "4", "23", "32", "51", "60", "81", "90", "111", "120", "142", "151", "174", "183", "206", "215", "238", "247", "270", "279", "302", "311", "329", "338", "x", "3", "24", "31", "52", "59", "82", "89", "112", "119", "143", "150", "175", "182", "207", "214", "239", "246", "271", "278", "303", "310", "330", "337", "341", "2", "25", "30", "53", "58", "83", "88", "113", "118", "144", "149", "176", "181", "208", "213", "240", "245", "272", "277", "304", "309", "331", "336", "342", "1", "26", "29", "54", "57", "84", "87", "114", "117", "145", "148", "177", "180", "209", "212", "241", "244", "273", "276", "305", "308", "332", "335", "343", "0", "27", "28", "55", "56", "85", "86", "115", "116", "146", "147", "178", "179", "210", "211", "242", "243", "274", "275", "306", "307", "333", "334", "344",];



class Wall15 extends StatelessWidget {
  final Function sendMessage;
  final List<String> presas;


  const Wall15({required this.sendMessage, required this.presas,});


  _shouldBuild(int index) => UNUSED_BUTTONS.contains(index);

  @override
  Widget build(BuildContext context) {


    int numOfButtonsUnused = 0;
    Color c2;

    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      reverse: false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 24,crossAxisSpacing:0, ),
      itemBuilder: (context,index ) {


        if(num15[index]=="x") {
          return  Container(color: Colors.transparent,);
        }else{
          if(presas.contains('${int.parse(num15[index])},16777215') == true) {   c2= Colors.white;
          return Container( color: Colors.transparent,child: Wall15Button(index: int.parse(num15[index]), sendMessage: sendMessage, presas: presas, c2: c2));
          }
          if(presas.contains('${int.parse(num15[index])},65280') == true) {   c2 = Colors.red;
          return Container( color: Colors.transparent,child: Wall15Button(index: int.parse(num15[index]), sendMessage: sendMessage, presas: presas, c2: c2));
          }
          if(presas.contains('${int.parse(num15[index])},16711680')== true) {   c2 =Colors.green;
          return Container( color: Colors.transparent,child: Wall15Button(index: int.parse(num15[index]), sendMessage: sendMessage, presas: presas, c2: c2));
          }
          if(presas.contains('${int.parse(num15[index])},255')== true) { c2= Colors.blue;
          return Container( color: Colors.transparent,child: Wall15Button(index: int.parse(num15[index]), sendMessage: sendMessage, presas: presas, c2: c2));
          }
          if(presas.contains('${int.parse(num15[index])},16776960')== true) {  c2 = Colors.yellow;
          return Container( color: Colors.transparent,child: Wall15Button(index: int.parse(num15[index]), sendMessage: sendMessage, presas: presas, c2: c2));
          }
          if(presas.contains('${int.parse(num15[index])},65535')== true) { c2= Colors.purple;
          return Container( color: Colors.transparent,child: Wall15Button(index: int.parse(num15[index]), sendMessage: sendMessage, presas: presas, c2: c2));

          }
          else{
            c2=Colors.transparent;
            return Container( color: Colors.transparent,child: Wall15Button(index: int.parse(num15[index]), sendMessage: sendMessage, presas: presas, c2: c2));

          }
        }
      },
      itemCount: 384,
    );
  }
}
