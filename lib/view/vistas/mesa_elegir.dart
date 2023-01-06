// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'package:api/utils/responsive.dart';
import 'package:api/utils/session.dart';
import 'package:api/widgets/cardBotones.dart';
import 'package:api/widgets/colores.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MesaElegir extends StatefulWidget {
  String? numeroMesa;
  int? numeroElectores;
  int? idMesaVotacion;
  int? codigoLocal;
  String? nombreLocal;
  int? idUbigeo;
  String? verificacionUbigeo;
  bool? actaLlena;
  MesaElegir(
      {Key? key,
      this.numeroMesa,
      this.numeroElectores,
      this.idMesaVotacion,
      this.codigoLocal,
      this.nombreLocal,
      this.idUbigeo,
      this.verificacionUbigeo,
      this.actaLlena})
      : super(key: key);

  @override
  State<MesaElegir> createState() => _MesaElegirState(
      numeroMesa,
      numeroElectores,
      idMesaVotacion,
      codigoLocal,
      nombreLocal,
      idUbigeo,
      verificacionUbigeo,
      actaLlena);
}

class _MesaElegirState extends State<MesaElegir> {
  String? numeroMesa;
  int? numeroElectores;
  int? idMesaVotacion;
  int? codigoLocal;
  String? nombreLocal;
  int? idUbigeo;
  String? verificacionUbigeo;
  bool? actaLlena;
  _MesaElegirState(
      this.numeroMesa,
      this.numeroElectores,
      this.idMesaVotacion,
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

  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsive = ResponsiveApp(context);
    var style =
        TextStyle(fontSize: responsive.dp(5), fontWeight: FontWeight.bold);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: FondoApp,
            leading: IconButton(
              //padding: const EdgeInsets.only(left: 350),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(color: AzulApp),
            ),
            title: const Text('', textAlign: TextAlign.right),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 25,
                                height: 7,
                                color: RojoApp,
                              ),
                              //padding: const EdgeInsets.all(8.0),
                              Text(
                                'MESA: ',
                                style: GoogleFonts.lato(
                                    textStyle: style, color: AzulApp),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(numeroMesa.toString(),
                              textScaleFactor: 1,
                              style: GoogleFonts.lato(
                                  textStyle: style, color: AzulApp)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              verificacionUbigeo == "D"
                  ? Column(
                      children: [
                        cardBotones(
                            context,
                            "DISTRITAL",
                            numeroMesa,
                            numeroElectores,
                            idMesaVotacion,
                            verificacionUbigeo,
                            nombreLocal,
                            idUbigeo,
                            codigoLocal),
                        cardBotones(
                            context,
                            "REGIONAL",
                            numeroMesa,
                            numeroElectores,
                            idMesaVotacion,
                            verificacionUbigeo,
                            nombreLocal,
                            idUbigeo,
                            codigoLocal),
                      ],
                    )
                  : Column(
                      children: [
                        cardBotones(
                            context,
                            "PROVINCIAL",
                            numeroMesa,
                            numeroElectores,
                            idMesaVotacion,
                            verificacionUbigeo,
                            nombreLocal,
                            idUbigeo,
                            codigoLocal),
                        cardBotones(
                            context,
                            "REGIONAL",
                            numeroMesa,
                            numeroElectores,
                            idMesaVotacion,
                            verificacionUbigeo,
                            nombreLocal,
                            idUbigeo,
                            codigoLocal),
                      ],
                    )
            ],
          )),
    );
  }
}
