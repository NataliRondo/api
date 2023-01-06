// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, no_logic_in_create_state

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:api/api/servicio_acta.dart';
import 'package:api/models/detalle/detalleDistrital.dart';
import 'package:api/utils/responsive.dart';
import 'package:api/utils/session.dart';
import 'package:api/widgets/colores.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class ActaDistrital extends StatefulWidget {
  List<DetalleDistrital>? detalleDistrital;
  String? datos;
  int? idMesaVotacion;
  String? observaciones;
  String? votosEmitidos;
  String? numeroMesa;
  int? numeroElectores;
  String? acta;
  int? codigoLocal;
  String? nombreLocal;
  int? idUbigeo;
  String? verificacionUbigeo;
  bool? actaLlena;
  ActaDistrital(
      {Key? key,
      this.datos,
      this.detalleDistrital,
      this.idMesaVotacion,
      this.observaciones,
      this.votosEmitidos,
      this.numeroMesa,
      this.numeroElectores,
      this.acta,
      this.codigoLocal,
      this.nombreLocal,
      this.idUbigeo,
      this.verificacionUbigeo,
      this.actaLlena})
      : super(key: key);
  @override
  _ActaDistritalState createState() => _ActaDistritalState(
      datos,
      detalleDistrital,
      idMesaVotacion,
      observaciones,
      votosEmitidos,
      numeroMesa,
      numeroElectores,
      acta,
      codigoLocal,
      nombreLocal,
      idUbigeo,
      verificacionUbigeo,
      actaLlena);
}

class _ActaDistritalState extends State<ActaDistrital> {
  ServicioActa servicioActa = ServicioActa();
  List<DetalleDistrital>? detalleDistrital;
  String? datos;
  int? idMesaVotacion;
  String? observaciones;
  String? votosEmitidos;
  String? numeroMesa;
  int? numeroElectores;
  String? acta;
  int? codigoLocal;
  String? nombreLocal;
  int? idUbigeo;
  String? verificacionUbigeo;
  bool? actaLlena;

  _ActaDistritalState(
      this.datos,
      this.detalleDistrital,
      this.idMesaVotacion,
      this.observaciones,
      this.votosEmitidos,
      this.numeroMesa,
      this.numeroElectores,
      this.acta,
      this.codigoLocal,
      this.nombreLocal,
      this.idUbigeo,
      this.verificacionUbigeo,
      this.actaLlena);

  void initState() {
    setState(() {
      CerrarSesionUsuario(context);
    });
    super.initState();
  }

  File? imagen;
  final picker = ImagePicker();
  bool flag = true;

  Future selimagen(op) async {
    XFile? pickedFile;
    if (op == 1) {
      pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 1920,
        maxWidth: 1080,
      );
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      if (pickedFile != null) {
        imagen = File(pickedFile.path);
      } else {
        print("No selecciono nada.");
      }
    });

    Navigator.of(context).pop();
  }

  opciones(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(2),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      selimagen(1);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text(
                              "Tomar foto",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Icon(
                            Icons.camera_alt,
                            color: Colors.blue,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      selimagen(2);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text(
                              "Seleccionar foto",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Icon(
                            Icons.image,
                            color: Colors.blue,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: RojoApp,
                      ),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text(
                              "Cancelar",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey keyScaffold = GlobalKey();
    ResponsiveApp responsive = ResponsiveApp(context);
    String imagen64;
    var style = TextStyle(
        fontSize: responsive.dp(4),
        fontWeight: FontWeight.bold,
        color: AzulApp);
    return Scaffold(
      key: keyScaffold,
      appBar: AppBar(
        backgroundColor: FondoApp,
        leading: IconButton(
          //padding: const EdgeInsets.only(left: 350),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(color: AzulApp),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "ACTA DISTRITAL",
                  style: style,
                ),
                Text(
                  "Mesa de votación: $numeroMesa",
                  style: style,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(AzulApp)),
                    onPressed: () {
                      opciones(context);
                    },
                    child: const Text(
                      "Subir foto de acta",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                if (imagen != null)
                  Column(
                    children: [
                      Center(
                        child: SizedBox(
                          height: 390,
                          width: 390,
                          child: Material(
                            elevation: 3,
                            child: Center(
                              child: Image.file(
                                imagen!,
                                width: 390,
                                height: 390,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(AzulApp)),
                          onPressed: () async {
                            imagen64 =
                                "data:image/png;base64,${base64Encode(File(imagen!.path).readAsBytesSync())}";
                            print(imagen);
                            if (flag) {
                              flag = false;
                              servicioActa.pasarDatosDistrital(
                                  idMesaVotacion,
                                  detalleDistrital,
                                  observaciones,
                                  imagen64,
                                  context,
                                  numeroMesa,
                                  numeroElectores,
                                  codigoLocal,
                                  nombreLocal,
                                  idUbigeo,
                                  verificacionUbigeo);
                              // enable click to take user to home screen
                            }

                            /*     
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("ok"),
                              ),
                            );
                            Mesas(codigoLocal: codigoLocal, nombreLocal: nombreLocal,)*/

                            //servicioMesa.validarMesa(idUbigeo, context, color, numeroMesa, porcentaje, numeroElectores, idMesaVotacion, codigoLocal, nombreLocal);
                          },
                          child: const Text(
                            "Guardar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  const Center()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
