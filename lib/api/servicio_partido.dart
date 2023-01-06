import 'dart:convert';
import 'package:api/utils/session.dart';
import 'package:http/http.dart' as http;
import 'package:api/models/partido.dart';
import 'package:api/models/token.dart';
import 'package:api/utils/variables.dart';

class ServicioPartidos{
  Future<List<Partido>> getPartido(int? idMesaVotacion, String? tipoActa) async {
    List<Partido> partidos = [];
    //inicio de usuario
    Token token = await Session();
    //fin de usuario
    String url = '$uri/api/acta/partidos?tipo=$tipoActa&idMesaVotacion=$idMesaVotacion';
    await http.get(Uri.parse(url), headers: {
      'Authorization': '${token.token}',
    }).then((dynamic res) {
      final Map<String, dynamic> body = jsonDecode(res.body);
      List<dynamic> data = body["Data"];
      if (body["Status"] == "Success") {
        for (var item in data) {
          Partido partido = Partido(
            idpartidopolitico: item['idpartidopolitico'],
            denominacion: item['denominacion'],
            logo: item['logo'],
            tipoAgrupacion: item['tipoAgrupacion'],
            auxOrden: item['auxOrden']
          );
          partidos.add(partido);
        }
      }
    });
    return partidos;
  }

}