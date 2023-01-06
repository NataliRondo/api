import 'dart:convert';

import 'package:api/models/local.dart';
import 'package:api/models/mesa.dart';
import 'package:api/models/token.dart';
import 'package:api/utils/session.dart';
import 'package:api/utils/variables.dart';
import 'package:api/view/vistas/mesa_elegir.dart';
import 'package:api/view/vistas/mesas.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ServicioMesa {
  Future<Mesa> buscarMesa(String numeroMesa, BuildContext context) async {
    Token token = await Session();
    Local local = Local();
    Mesa mesa = Mesa();
    String url = '$uri/api/Mesa/BuscarMesa?nroMesa=$numeroMesa';
    bool flag = true;
    return http.post(Uri.parse(url), headers: {
      'Authorization': '${token.token}',
    }).then((dynamic res) {
      final Map<String, dynamic> body = jsonDecode(res.body);

      if (body["Status"] == "Success") {
        local = Local.fromJson(body["Resultado"]);
        mesa = Mesa.fromJson(body["Data"]);

        //if (direccion.codProvinciaR == mesa.auxCodProvinciaR) {
        if (flag) {
          flag = false;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Mesas(
                numeroMesa: numeroMesa,
                codigoLocal: int.parse(local.codLocalVotacion!),
                nombreLocal: local.nombreLocal,
                idUbigeo: local.idUbigeo,
                numeroElectores: mesa.tElectroesHabiles,
                idMesaVotacion: mesa.idMesaVotacion,
              ),
            ),
          ).then((value) => numeroMesa == "");
        }
        // } else {
        //showMyDialog(context, "No puede acceder",
        //    "Esta mesa no pertenece a su provincia.");
        //}

        // Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Mesa incorrecta"),
          ),
        );
      }
      return mesa;
    });
  }

  Future validarMesa(
    int? idUbigeo,
    BuildContext context,
    Color color,
    String numeroMesa,
    String porcentaje,
    int? numeroElectores,
    int? idMesaVotacion,
    int? codigoLocal,
    String? nombreLocal,
  ) async {
    Token token = await Session();
    String url = '$uri/api/Ubigeo/ValidarUbigeo?idUbigeo=$idUbigeo';
    String actaUbigeo = "";
    bool flag = true;
    //bool? actaLlena;
    try {
      return http.post(Uri.parse(url), headers: {
        'Authorization': '${token.token}',
        "Content-Type": "application/json"
      }).then((dynamic res) {
        final Map<String, dynamic> body = jsonDecode(res.body);
        if (body["Status"] == "Info") {
          //if (body["Message"] == "D") {
          actaUbigeo = body["Message"];
          //actaLlena = true;
          if (flag) {
            flag = false;
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MesaElegir(
                  numeroMesa: numeroMesa.toString(),
                  numeroElectores: numeroElectores,
                  idMesaVotacion: idMesaVotacion,
                  codigoLocal: codigoLocal,
                  nombreLocal: nombreLocal,
                  idUbigeo: idUbigeo,
                  verificacionUbigeo: actaUbigeo,
                  //actaLlena: actaLlena,
                ),
              ),
            );
          }
          // }
        }
      });
    } catch (e) {}
  }
}
