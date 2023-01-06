import 'dart:convert';

import 'package:api/models/token.dart';
import 'package:api/widgets/alertDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: non_constant_identifier_names
Future<Token> Session() async {
  Token token = Token();
  SharedPreferences pref = await SharedPreferences.getInstance();
  List<String>? session = pref.getStringList("usuario")!.toList();
  token = Token.fromJson(json.decode(session[1].toString()));
  return token;
}

Future cerrarSesion(BuildContext context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.clear();
  FocusScope.of(context).requestFocus(FocusNode());
  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
}

Future<void> CerrarSesionUsuario(BuildContext context) async {
  Token token = Token();
  SharedPreferences pref = await SharedPreferences.getInstance();
  List<String>? session = pref.getStringList("usuario");
  if (session != null) {
    token = Token.fromJson(json.decode(session[1].toString()));
    DateTime currentDate = DateTime.now();
    DateTime? tokeninicio = token.inicio;
    int? tokenVencimiento = int.parse(token.vencimiento.toString());
    int diff = currentDate.difference(tokeninicio!).inMinutes;
    print(diff);
    print(currentDate);
    print(tokeninicio);
    //minutes

    var resta = tokenVencimiento - diff;
    print(resta);
    if (resta >= 2) {
      if (resta == 1) {
        showMyDialog(context, "Inicio de sesión",
            "La sesión expirará pronto, ingrese de nuevo.");
      }
      return Future.delayed(Duration(minutes: resta), () {
        //minutes
        cerrarSesion(context);
      });
    } else {
      cerrarSesion(context);
    }
  }
}
