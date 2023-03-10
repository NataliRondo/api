// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

class HexColor extends Color {
  static int _getColor(String hex) {
    String formattedHex =  "FF${hex.toUpperCase().replaceAll("#", "")}";
    return int.parse(formattedHex, radix: 16);
  }
  HexColor(final String hex) : super(_getColor(hex));
}
Color FondoApp = HexColor('#f7f7f7');
Color AzulApp = HexColor('#004b9c');
Color RojoApp = HexColor('#e30000');
//Color Whatsapp = HexColor("#128c7e");
Color Whatsapp = HexColor("#48c757");
