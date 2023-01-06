import 'dart:convert';

import 'package:api/models/local.dart';
import 'package:api/models/mesa.dart';
import 'package:api/models/token.dart';
import 'package:api/utils/session.dart';
import 'package:api/utils/variables.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServicePersonero {
  Future<List<Local>> getLocales(int? perCodigo) async {
    List<Local> locales = [];
    //inicio de usuario
    Token token = await Session();
    //fin de usuario
    String url = '$uri/api/personero/MisLocales?id=$perCodigo';
    await http.get(Uri.parse(url), headers: {
      'Authorization': '${token.token}',
    }).then((dynamic res) {
      final Map<String, dynamic> body = jsonDecode(res.body);
      List<dynamic> data = body["Data"];
      if (body["Status"] == "Success") {
        for (var item in data) {
          Local local = Local(
            idLocalVotacion: item["idLocalVotacion"],
            codLocalVotacion: item["codLocalVotacion"],
            nombreLocal: item["nombreLocal"],
            direccion: item["direccion"],
            referencia: item["referencia"],
            idUbigeo: item["idUbigeo"],
          );
          locales.add(local);
        }
      }
    });
    return locales;
  }

  Future<List<Mesa>> getMesas(
      int? perCodigo, int? idLocalVotacion, String? nombreLocal) async {
    List<Mesa> mesas = [];
    //inicio de usuario
    Token token = Token();
    //Direccion direccion = Direccion();
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? session = pref.getStringList("usuario")!.toList();
    token = Token.fromJson(json.decode(session[1].toString()));
    //fin de usuario
    String url =
        '$uri/api/personero/MisMesas?local=$idLocalVotacion&id=$perCodigo';
    await http.get(Uri.parse(url), headers: {
      'Authorization': '${token.token}',
    }).then((dynamic res) {
      final Map<String, dynamic> body = jsonDecode(res.body);
      List<dynamic> data = body["Data"];
      //direccion = Direccion.fromJson(body["data"]["direccion"]);
      if (body["Status"] == "Success") {
        for (var item in data) {
          Mesa mesa = Mesa(
              idLocalVotacion: item["$idLocalVotacion"],
              idMesaVotacion: item["idMesaVotacion"],
              nroMesa: item["nroMesa"],
              tElectroesHabiles: item["tElectroesHabiles"],
              auxCodProvinciaR: item["auxCodProvinciaR"]);
          mesas.add(mesa);
        }
      }
    });
    return mesas;
  }
}
