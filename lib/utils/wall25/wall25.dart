import 'package:flutter/material.dart';
import 'package:sunboards_vuit/utils/wall25/button25_add.dart';

const List<int> UNUSED_BUTTONS = [14,15,30,31,46,47,62,63,79,95,111,127,143,335,348,349,350,351,359,360,361,362,363,364,365,366,367,372,373,374,375,376,377,378,379,380,381,382,383];
const List<String> num25 =[ "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x","x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x","472", "471", "436", "435", "400", "399", "364", "363", "328", "327", "292", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "473", "470", "437", "434", "401", "398", "365", "362", "329", "326", "293", "291", "258", "257", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "474", "469", "438", "433", "402", "397", "366", "361", "330", "325", "294", "290", "259", "256", "225", "224", "193", "192", "161", "160", "129", "x", "x", "x", "x", "x", "x", "x", "x", "x", "475", "468", "439", "432", "403", "396", "367", "360", "331", "324", "295", "289", "260", "255", "226", "223", "194", "191", "162", "159", "130", "128", "99", "98", "69", "x", "x", "x", "x", "x", "476", "467", "440", "431", "404", "395", "368", "359", "332", "323", "296", "288", "261", "254", "227", "222", "195", "190", "163", "158", "131", "127", "100", "97", "70", "68", "41", "40", "13", "x", "477", "466", "441", "430", "405", "394", "369", "358", "333", "322", "297", "287", "262", "253", "228", "221", "196", "189", "164", "157", "132", "126", "101", "96", "71", "67", "42", "39", "14", "12", "478", "465", "442", "429", "406", "393", "370", "357", "334", "321", "298", "286", "263", "252", "229", "220", "197", "188", "165", "156", "133", "125", "102", "95", "72", "66", "43", "38", "15", "11", "479", "464", "443", "428", "407", "392", "371", "356", "335", "320", "299", "285", "264", "251", "230", "219", "198", "187", "166", "155", "134", "124", "103", "94", "73", "65", "44", "37", "16", "10", "480", "463", "444", "427", "408", "391", "372", "355", "336", "319", "300", "284", "265", "250", "231", "218", "199", "186", "167", "154", "135", "123", "104", "93", "74", "64", "45", "36", "17", "9", "481", "462", "445", "426", "409", "390", "373", "354", "337", "318", "301", "283", "266", "249", "232", "217", "200", "185", "168", "153", "136", "122", "105", "92", "75", "63", "46", "35", "18", "8", "482", "461", "446", "425", "410", "389", "374", "353", "338", "317", "302", "282", "267", "248", "233", "216", "201", "184", "169", "152", "137", "121", "106", "91", "76", "62", "47", "34", "19", "7", "483", "460", "447", "424", "411", "388", "375", "352", "339", "316", "303", "281", "268", "247", "234", "215", "202", "183", "170", "151", "138", "120", "107", "90", "77", "61", "48", "33", "20", "6", "484", "459", "448", "423", "412", "387", "376", "351", "340", "315", "304", "280", "269", "246", "235", "214", "203", "182", "171", "150", "139", "119", "108", "89", "78", "60", "49", "32", "21", "5", "485", "458", "449", "422", "413", "386", "377", "350", "341", "314", "305", "279", "270", "245", "236", "213", "204", "181", "172", "149", "140", "118", "109", "88", "79", "59", "50", "31", "22", "4", "486", "457", "450", "421", "414", "385", "378", "349", "342", "313", "306", "278", "271", "244", "237", "212", "205", "180", "173", "148", "141", "117", "110", "87", "80", "58", "51", "30", "23", "3", "487", "456", "451", "420", "415", "384", "379", "348", "343", "312", "307", "277", "272", "243", "238", "211", "206", "179", "174", "147", "142", "116", "111", "86", "81", "57", "52", "29", "24", "2", "488", "455", "452", "419", "416", "383", "380", "347", "344", "311", "308", "276", "273", "242", "239", "210", "207", "178", "175", "146", "143", "115", "112", "85", "82", "56", "53", "28", "25", "1", "489", "454", "453", "418", "417", "382", "381", "346", "345", "310", "309", "275", "274", "241", "240", "209", "208", "177", "176", "145", "144", "114", "113", "84", "83", "55", "54", "27", "26", "0",];

class Wall25 extends StatelessWidget {
  final Function sendMessage;
  final List<String> presas;
  const Wall25({required this.sendMessage, required this.presas});

  _shouldBuild(int index) => UNUSED_BUTTONS.contains(index);

  @override
  Widget build(BuildContext context) {
    int numOfButtonsUnused = 0;
    Color c2;
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      reverse: false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 30,crossAxisSpacing:0, ),
      itemBuilder: (context,index ) {
        if (num25[index] == "x") {
          return Container(color: Colors.transparent,);
        } else {
          if (presas.contains('${int.parse(num25[index])},16777215') == true) {
            c2 = Colors.white;
            return Container(color: Colors.transparent,
                child: Wall25Button(index: int.parse(num25[index]),
                    sendMessage: sendMessage,
                    presas: presas,
                    c2: c2));
          }
          if (presas.contains('${int.parse(num25[index])},65280') == true) {
            c2 = Colors.red;
            return Container(color: Colors.transparent,
                child: Wall25Button(index: int.parse(num25[index]),
                    sendMessage: sendMessage,
                    presas: presas,
                    c2: c2));
          }
          if (presas.contains('${int.parse(num25[index])},16711680') == true) {
            c2 = Colors.green;
            return Container(color: Colors.transparent,
                child: Wall25Button(index: int.parse(num25[index]),
                    sendMessage: sendMessage,
                    presas: presas,
                    c2: c2));
          }
          if (presas.contains('${int.parse(num25[index])},255') == true) {
            c2 = Colors.blue;
            return Container(color: Colors.transparent,
                child: Wall25Button(index: int.parse(num25[index]),
                    sendMessage: sendMessage,
                    presas: presas,
                    c2: c2));
          }
          if (presas.contains('${int.parse(num25[index])},16776960') == true) {
            c2 = Colors.yellow;
            return Container(color: Colors.transparent,
                child: Wall25Button(index: int.parse(num25[index]),
                    sendMessage: sendMessage,
                    presas: presas,
                    c2: c2));
          }
          if (presas.contains('${int.parse(num25[index])},65535') == true) {
            c2 = Colors.purple;
            return Container(color: Colors.transparent,
                child: Wall25Button(index: int.parse(num25[index]),
                    sendMessage: sendMessage,
                    presas: presas,
                    c2: c2));
          }
          else {
            c2 = Colors.transparent;
            return Container(color: Colors.transparent,
                child: Wall25Button(index: int.parse(num25[index]),
                    sendMessage: sendMessage,
                    presas: presas,
                    c2: c2));
          }
        }
      },
      itemCount: 570,
    );
  }
}
