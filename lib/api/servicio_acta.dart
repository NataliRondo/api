import 'dart:convert';
import 'package:api/models/acta/actaDistrital.dart';
import 'package:api/models/acta/actaProvincial.dart';
import 'package:api/models/acta/actaRegional.dart';
import 'package:api/models/detalle/detalle.dart';
import 'package:api/models/detalle/detalleDistrital.dart';
import 'package:api/models/detalle/detalleProvincial.dart';
import 'package:api/models/token.dart';
import 'package:api/utils/session.dart';
import 'package:api/utils/variables.dart';
import 'package:api/view/vistas/mesa_elegir.dart';
import 'package:api/view/vistas/partidosView.dart';
import 'package:api/widgets/alertDialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ServicioActa {
  Future pasarDatosRegional(
      int? idMesaVotacion,
      List<Detalle>? listaDetalle,
      String? observaciones,
      String? imagen,
      BuildContext context,
      String? numeroMesa,
      int? numeroElectores,
      int? codigoLocal,
      String? nombreLocal,
      int? idUbigeo,
      String? verificacionUbigeo) async {
    Token token = await Session();

    ActaRegionalModelo acta = ActaRegionalModelo(
        idMesaVotacion: idMesaVotacion,
        imagen: "$imagen",
        observaciones: observaciones,
        detalle: listaDetalle);

    var jsonEncodeActa = jsonEncode(acta);
    String url = '$uri/api/acta/AgregarActaRegional';
    bool flag = true;
    try {
      return http.post(Uri.parse(url), body: jsonEncodeActa, headers: {
        'Authorization': '${token.token}',
        "Content-Type": "application/json"
      }).then((dynamic res) {
        //var error = res.statusText;
        final Map<String, dynamic> body = jsonDecode(res.body);
        var mensaje = body["Message"];
        if (body["Status"] == "Success") {
          if (flag) {
            flag = false;
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => MesaElegir(
                  numeroMesa: numeroMesa,
                  numeroElectores: numeroElectores,
                  idMesaVotacion: idMesaVotacion,
                  codigoLocal: codigoLocal,
                  nombreLocal: nombreLocal,
                  idUbigeo: idUbigeo,
                  verificacionUbigeo: verificacionUbigeo,
                ),
              ),
              ModalRoute.withName('/distritos'),
            );
          }
          /* ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("ok"),
            ),
          );*/
        } else {
          showMyDialog(context, "Error", "$mensaje");
        }
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future pasarDatosProvincial(
    int? idMesaVotacion,
    List<DetalleProvincial>? listaDetalleProvincial,
    String? observaciones,
    String? imagen,
    BuildContext context,
    String? numeroMesa,
    int? numeroElectores,
    int? codigoLocal,
    String? nombreLocal,
    int? idUbigeo,
    String? verificacionUbigeo,
  ) async {
    Token token = await Session();

    ActaProvincialModelo acta = ActaProvincialModelo(
        idMesaVotacion: idMesaVotacion,
        imagen: "$imagen",
        observaciones: observaciones,
        detalle: listaDetalleProvincial);

    var jsonEncodeActa = jsonEncode(acta);
    String url = '$uri/api/acta/AgregarActaProvincial';
    bool flag = true;
    try {
      return http.post(Uri.parse(url), body: jsonEncodeActa, headers: {
        'Authorization': '${token.token}',
        "Content-Type": "application/json"
      }).then((dynamic res) {
        //var error = res.statusText;
        final Map<String, dynamic> body = jsonDecode(res.body);
        var mensaje = body["Message"];
        if (body["Status"] == "Success") {
          if (flag) {
            flag = false;
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => MesaElegir(
                  numeroMesa: numeroMesa,
                  numeroElectores: numeroElectores,
                  idMesaVotacion: idMesaVotacion,
                  codigoLocal: codigoLocal,
                  nombreLocal: nombreLocal,
                  idUbigeo: idUbigeo,
                  verificacionUbigeo: verificacionUbigeo,
                ),
              ),
              ModalRoute.withName('/distritos'),
            );
          }
          /*ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("ok"),
            ),
          );*/
        } else {
          showMyDialog(context, "Error", "$mensaje");
        }
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future pasarDatosDistrital(
      int? idMesaVotacion,
      List<DetalleDistrital>? listaDetalleDistrital,
      String? observaciones,
      String? imagen,
      BuildContext context,
      String? numeroMesa,
      int? numeroElectores,
      int? codigoLocal,
      String? nombreLocal,
      int? idUbigeo,
      String? verificacionUbigeo) async {
    Token token = await Session();

    ActaDistritalModelo acta = ActaDistritalModelo(
        idMesaVotacion: idMesaVotacion,
        imagen: "$imagen",
        observaciones: observaciones,
        detalle: listaDetalleDistrital);

    var jsonEncodeActa = jsonEncode(acta);
    String url = '$uri/api/acta/AgregarActaDistrital';
    bool flag = true;
    try {
      return http.post(Uri.parse(url), body: jsonEncodeActa, headers: {
        'Authorization': '${token.token}',
        "Content-Type": "application/json"
      }).then((dynamic res) {
        //var error = res.statusText;
        final Map<String, dynamic> body = jsonDecode(res.body);
        var mensaje = body["Message"];
        if (body["Status"] == "Success") {
          if (flag) {
            flag = false;
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => MesaElegir(
                  numeroMesa: numeroMesa,
                  numeroElectores: numeroElectores,
                  idMesaVotacion: idMesaVotacion,
                  codigoLocal: codigoLocal,
                  nombreLocal: nombreLocal,
                  idUbigeo: idUbigeo,
                  verificacionUbigeo: verificacionUbigeo,
                ),
              ),
              ModalRoute.withName('/distritos'),
            );
          }
          /* ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("ok"),
            ),
          );*/
        } else {
          showMyDialog(context, "Error", "$mensaje");
        }
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future verificarActaDistrital(
      String? acta,
      String? numeroMesa,
      int? numeroElectores,
      int? idMesaVotacion,
      BuildContext context,
      String? verificacionUbigeo,
      String? nombreLocal,
      int? ubigeo,
      int? codigoLocal) async {
    Token token = await Session();
    //String respuesta = "";
    String url = '$uri/api/acta/VerificaActaRegistradaD?id=$idMesaVotacion';
    bool flag = true;
    try {
      return http.get(Uri.parse(url), headers: {
        'Authorization': '${token.token}',
      }).then((dynamic res) async {
        final Map<String, dynamic> body = jsonDecode(res.body);
        if (acta == "DISTRITAL") {
          if (body["Status"] == "Success") {
            //actaLlena = true;
            showMyDialog(
                context, "Acta Distrital", "Esta acta ya ha sido registrada");
          } else if (body["Status"] == "Info") {
            if (flag) {
              flag = false;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PartidosView(
                    numeroMesa: numeroMesa,
                    numeroElectores: numeroElectores,
                    acta: acta,
                    idMesaVotacion: idMesaVotacion,
                    verificacionUbigeo: verificacionUbigeo,
                    nombreLocal: nombreLocal,
                    idUbigeo: ubigeo,
                    codigoLocal: codigoLocal,
                  ),
                ),
              );
            }
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future verificarActaProvincial(
      String? acta,
      String? numeroMesa,
      int? numeroElectores,
      int? idMesaVotacion,
      BuildContext context,
      String? verificacionUbigeo,
      String? nombreLocal,
      int? ubigeo,
      int? codigoLocal) async {
    Token token = await Session();
    //String respuesta = "";
    String url = '$uri/api/acta/VerificaActaRegistradaP?id=$idMesaVotacion';
    bool flag = true;
    try {
      return http.get(Uri.parse(url), headers: {
        'Authorization': '${token.token}',
      }).then((dynamic res) async {
        final Map<String, dynamic> body = jsonDecode(res.body);
        if (acta == "PROVINCIAL") {
          if (body["Status"] == "Success") {
            showMyDialog(
                context, "Acta Provincial", "Esta acta ya ha sido registrada");
          } else if (body["Status"] == "Info") {
            //respuesta = "Info";
            if (flag) {
              flag = false;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PartidosView(
                    numeroMesa: numeroMesa,
                    numeroElectores: numeroElectores,
                    acta: acta,
                    idMesaVotacion: idMesaVotacion,
                    verificacionUbigeo: verificacionUbigeo,
                    nombreLocal: nombreLocal,
                    idUbigeo: ubigeo,
                    codigoLocal: codigoLocal,
                  ),
                ),
              );
            }
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future verificarActaRegional(
      String? acta,
      String? numeroMesa,
      int? numeroElectores,
      int? idMesaVotacion,
      BuildContext context,
      String? verificacionUbigeo,
      String? nombreLocal,
      int? ubigeo,
      int? codigoLocal) async {
    Token token = await Session();
    //String respuesta = "";
    String url = '$uri/api/acta/VerificaActaRegistrada?id=$idMesaVotacion';
    bool flag = true;
    try {
      return http.get(Uri.parse(url), headers: {
        'Authorization': '${token.token}',
      }).then((dynamic res) async {
        final Map<String, dynamic> body = jsonDecode(res.body);
        if (acta == "REGIONAL") {
          if (body["Status"] == "Success") {
            showMyDialog(
                context, "Acta Regional", "Esta acta ya ha sido registrada");
          } else if (body["Status"] == "Info") {
            if (flag) {
              flag = false;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PartidosView(
                    numeroMesa: numeroMesa,
                    numeroElectores: numeroElectores,
                    acta: acta,
                    idMesaVotacion: idMesaVotacion,
                    verificacionUbigeo: verificacionUbigeo,
                    nombreLocal: nombreLocal,
                    idUbigeo: ubigeo,
                    codigoLocal: codigoLocal,
                  ),
                ),
              );
            }
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
