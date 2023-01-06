import 'dart:convert';
import 'package:api/utils/session.dart';
import 'package:http/http.dart' as http;
import 'package:api/models/soporte.dart';
import 'package:api/models/token.dart';
import 'package:api/utils/variables.dart';

class ServicioSoporte {
  Future<List<Soporte>> getSoporte() async {
    List<Soporte> soporteLista = [];
    //inicio de usuario
    Token token = await Session();
    //fin de usuario
    String url = '$uri/api/General/ListarSoporte?=';
    await http.get(Uri.parse(url), headers: {
      'Authorization': '${token.token}',
    }).then((dynamic res) {
      final Map<String, dynamic> body = jsonDecode(res.body);
      List<dynamic> data = body["Data"];
      if (body["Status"] == "Success") {
        for (var item in data) {
          Soporte soporte = Soporte(
            id: item['id'],
            nombre: item['nombre'],
            celular: item['celular'],
          );
          soporteLista.add(soporte);
        }
      }
    });
    return soporteLista;
  }
}
