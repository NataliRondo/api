// ignore_for_file: use_build_context_synchronously, no_logic_in_create_state, must_be_immutable

import 'dart:convert';

import 'package:api/api/servicio_personero.dart';
import 'package:api/models/mesa.dart';
import 'package:api/models/token.dart';
import 'package:api/models/usuario.dart';
import 'package:api/utils/session.dart';
import 'package:api/utils/variables.dart';
import 'package:api/widgets/cardMesas.dart';
import 'package:api/widgets/colores.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mesas extends StatefulWidget {
  String? numeroMesa;
  int? codigoLocal;
  String? nombreLocal;
  int? idUbigeo;
  int? numeroElectores;
  int? idMesaVotacion;
  String? verificacionUbigeo;
  Mesas(
      {Key? key,
      this.numeroMesa,
      this.codigoLocal,
      this.nombreLocal,
      this.idUbigeo,
      this.numeroElectores,
      this.idMesaVotacion,
      this.verificacionUbigeo})
      : super(key: key);

  @override
  State<Mesas> createState() => _MesasState(
      numeroMesa,
      codigoLocal,
      nombreLocal,
      idUbigeo,
      numeroElectores,
      idMesaVotacion,
      verificacionUbigeo);
}

class _MesasState extends State<Mesas> {
  String? numeroMesa;
  int? codigoLocal;
  String? nombreLocal;
  int? idUbigeo;
  int? numeroElectores;
  int? idMesaVotacion;
  String? verificacionUbigeo;
  _MesasState(
      this.numeroMesa,
      this.codigoLocal,
      this.nombreLocal,
      this.idUbigeo,
      this.numeroElectores,
      this.idMesaVotacion,
      this.verificacionUbigeo);
  Usuario usuario = Usuario();
  Token token = Token();
  ServicePersonero servicio = ServicePersonero();
  Mesa mesa = Mesa();

  @override
  void initState() {
    setState(() {
      CerrarSesionUsuario(context);
    });
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      List<String>? extra = pref.getStringList("usuario")!.toList();
      usuario = Usuario.fromJson(json.decode(extra[0].toString()));
      token = Token.fromJson(json.decode(extra[1].toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    String nombre = usuario.perNombre.toString();

    int? codigo = usuario.perCodigo;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FondoApp,
        leading: IconButton(
            //padding: const EdgeInsets.only(left: 350),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              Navigator.pop(context);
              FocusScope.of(context).requestFocus(FocusNode());
            }),
        flexibleSpace: Container(
          decoration: BoxDecoration(color: AzulApp),
        ),
        title: Text(nombre, textAlign: TextAlign.right),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: servicio.getMesas(codigo, codigoLocal, nombreLocal),
            builder: ((context, AsyncSnapshot<List<Mesa>> snapshot) {
              if (snapshot.hasData) {
                List<Mesa>? mesas = snapshot.data;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 250, left: 10),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 75),
                            child: Container(
                              width: 30,
                              height: 7,
                              color: RojoApp,
                              //padding: EdgeInsets.only(left: 1),
                              alignment: Alignment.topLeft,
                            ),
                          ),
                          Text(
                            'Mis Mesas',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.lato(
                                textStyle: style, color: AzulApp),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 70, left: 30),
                      child: Text(
                        'Local: ${nombreLocal.toString()}',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.lato(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    numeroMesa == null
                        ? Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: mesas!
                                  .map(
                                    (Mesa mesa) => cardMesas(
                                      context,
                                      RojoApp,
                                      mesa.nroMesa.toString(),
                                      "",
                                      mesa.tElectroesHabiles,
                                      mesa.idMesaVotacion,
                                      codigoLocal,
                                      nombreLocal,
                                      idUbigeo,
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: [
                                cardMesas(
                                  context,
                                  RojoApp,
                                  numeroMesa.toString(),
                                  "",
                                  numeroElectores,
                                  idMesaVotacion,
                                  codigoLocal,
                                  nombreLocal,
                                  idUbigeo,
                                ),
                              ],
                            ),
                          ),
                  ],
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
