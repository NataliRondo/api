// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, no_logic_in_create_state

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:api/api/servicio_acta.dart';
import 'package:api/models/detalle/detalle.dart';
import 'package:api/utils/responsive.dart';
import 'package:api/utils/session.dart';
import 'package:api/view/login/login.dart';
import 'package:api/widgets/colores.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ActaRegional extends StatefulWidget {
  List<Detalle>? detalle;
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
  ActaRegional(
      {Key? key,
      this.datos,
      this.detalle,
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
  _ActaRegionalState createState() => _ActaRegionalState(
      datos,
      detalle,
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

class _ActaRegionalState extends State<ActaRegional> {
  ServicioActa servicioActa = ServicioActa();
  List<Detalle>? detalle;
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
  _ActaRegionalState(
      this.datos,
      this.detalle,
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

  @override
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
        print("No selecciono nada");
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
        /*actions: [
          IconButton(
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            icon: const Icon(
              Icons.person,
            ),
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              await pref.clear();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (Route<dynamic> route) => false);
            },
          ),
        ],*/
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "ACTA REGIONAL",
                  style: style,
                ),
                Text(
                  "Mesa de votaci??n: $numeroMesa",
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
                            //File cropper = ImageCropper.cropImage(sourcePath: imagen,compressQuality: 60);
                            imagen64 =
                                "data:image/png;base64,${base64Encode(File(imagen!.path).readAsBytesSync())}";
                            print(imagen);
                            if (flag) {
                              flag = false;
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );
                              servicioActa.pasarDatosRegional(
                                  idMesaVotacion,
                                  detalle,
                                  observaciones,
                                  imagen64,
                                  context,
                                  numeroMesa,
                                  numeroElectores,
                                  codigoLocal,
                                  nombreLocal,
                                  idUbigeo,
                                  verificacionUbigeo);
                              Navigator.of(context).pop();
                              // enable click to take user to home screen
                            }
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
