// ignore_for_file: no_logic_in_create_state, must_be_immutable, use_build_context_synchronously, file_names

import 'dart:convert';
import 'dart:typed_data';

import 'package:api/api/servicio_partido.dart';
import 'package:api/api/servicio_personero.dart';
import 'package:api/models/detalle/detalle.dart';
import 'package:api/models/detalle/detalleDistrital.dart';
import 'package:api/models/detalle/detalleProvincial.dart';
import 'package:api/models/local.dart';
import 'package:api/models/token.dart';
import 'package:api/models/usuario.dart';
import 'package:api/utils/responsive.dart';
import 'package:api/utils/session.dart';
import 'package:api/view/vistas/actas/actasfotoDistrital.dart';
import 'package:api/view/vistas/actas/actasfotoProvincial.dart';
import 'package:api/view/vistas/actas/actasfotoRegional.dart';
import 'package:api/widgets/alertDialog.dart';
import 'package:api/widgets/colores.dart';
import 'package:api/widgets/partidosWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PartidosView extends StatefulWidget {
  String? numeroMesa;
  String? acta;
  int? numeroElectores;
  int? idMesaVotacion;
  int? codigoLocal;
  String? nombreLocal;
  int? idUbigeo;
  String? verificacionUbigeo;
  bool? actaLlena;
  PartidosView(
      {Key? key,
      this.numeroMesa,
      this.numeroElectores,
      this.acta,
      this.idMesaVotacion,
      this.codigoLocal,
      this.nombreLocal,
      this.idUbigeo,
      this.verificacionUbigeo,
      this.actaLlena})
      : super(key: key);

  @override
  State<PartidosView> createState() => _PartidosViewState(
      numeroMesa,
      numeroElectores,
      acta,
      idMesaVotacion,
      codigoLocal,
      nombreLocal,
      idUbigeo,
      verificacionUbigeo,
      actaLlena);
}

class _PartidosViewState extends State<PartidosView> {
  String? numeroMesa;
  String? acta;
  int? numeroElectores;
  int? idMesaVotacion;
  int? codigoLocal;
  String? nombreLocal;
  int? idUbigeo;
  String? verificacionUbigeo;
  bool? actaLlena;

  String? valor;

  _PartidosViewState(
      this.numeroMesa,
      this.numeroElectores,
      this.acta,
      this.idMesaVotacion,
      this.codigoLocal,
      this.nombreLocal,
      this.idUbigeo,
      this.verificacionUbigeo,
      this.actaLlena);

  Usuario usuario = Usuario();
  Token token = Token();
  ServicePersonero servicio = ServicePersonero();
  Local local = Local();
  //Mesa mesa = Mesa();
  ServicioPartidos servicioPartidos = ServicioPartidos();

  //Partido partido = Partido();
  TextEditingController votosEmitidos = TextEditingController();
  TextEditingController votosEmitidosConsejero = TextEditingController();
  TextEditingController observaciones = TextEditingController();
  final List<TextEditingController> _controllersVotos = [];
  final List<TextEditingController> _controllersVotosConsejero = [];
  final _formKey = GlobalKey<FormState>();
  List<String> listaVotosGobierno = [];
  List<String> listaVotosConsejero = [];
  int sumaFinal = 0;
  int sumaFinalConsejero = 0;
  //
  @override
  void initState() {
    setState(() {
      CerrarSesionUsuario(context);
      votosEmitidos.text = sumaFinal.toString();
      votosEmitidosConsejero.text = sumaFinalConsejero.toString();
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
    //GlobalKey partidosKey = GlobalKey();

    ResponsiveApp responsive = ResponsiveApp(context);
    String? inicialActa = acta?.substring(0, 1).toString().toUpperCase();
    var style2 =
        TextStyle(fontSize: responsive.dp(5), fontWeight: FontWeight.bold);
    var style3 =
        TextStyle(fontSize: responsive.dp(4), fontWeight: FontWeight.bold);
    var style4 =
        TextStyle(fontSize: responsive.dp(2.6), fontWeight: FontWeight.bold);
    var servicio = servicioPartidos.getPartido(idMesaVotacion, inicialActa);

    List<String> partidoValorController = [];
    List<String> votosConsejeroControlador = [];

    List<Detalle> listaDetalleRegional = [];
    //List<DetalleProvincial> listaDetalleVotos = [];
    List<DetalleDistrital> listaDetalleDistrital = [];
    List<DetalleProvincial> listaDetalleProvincial = [];

    String num = "";

    var prueba = <int, String>{};
    return Scaffold(
      appBar: AppBar(
        title: Text(
          acta.toString(),
          style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: FondoApp,
        leading: IconButton(
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(color: AzulApp),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: FutureBuilder(
                initialData: const [],
                future: servicio,
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!.length;
                    prueba.clear();
                    partidoValorController.clear();
                    votosConsejeroControlador.clear();
                    listaDetalleRegional.clear();
                    //listaDetalleVotos.clear();
                    listaDetalleProvincial.clear();
                    listaDetalleDistrital.clear();
                    listaVotosGobierno.clear();
                    listaVotosConsejero.clear();

                    return SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(responsive.dp(3.5)),
                        child: Column(
                          children: [
                            SizedBox(height: responsive.hp(5)),
                            Table(
                              children: [
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: responsive.dp(2)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: responsive.wp(6),
                                            height: responsive.hp(1.5),
                                            color: RojoApp,
                                          ),
                                          Text(
                                            'MESA: ',
                                            style: GoogleFonts.lato(
                                                textStyle: style2,
                                                color: AzulApp),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(responsive.dp(2)),
                                      child: Text(
                                        numeroMesa.toString(),
                                        textScaleFactor: 1,
                                        style: GoogleFonts.lato(
                                            textStyle: style2, color: AzulApp),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: responsive.dp(2)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'ACTA: ',
                                            style: GoogleFonts.lato(
                                                textStyle: style2,
                                                color: AzulApp),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(responsive.dp(2)),
                                      child: Text(
                                        acta.toString(),
                                        textScaleFactor: 1,
                                        style: GoogleFonts.lato(
                                            textStyle: style2, color: AzulApp),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(responsive.dp(2)),
                                      child: Text(
                                        "Total de electores hábiles:",
                                        textScaleFactor: 1,
                                        style: GoogleFonts.lato(
                                            textStyle: style2, color: AzulApp),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(responsive.dp(2)),
                                      child: Text(
                                        numeroElectores.toString(),
                                        textScaleFactor: 1,
                                        style: GoogleFonts.lato(
                                            textStyle: style2, color: AzulApp),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Material(
                              elevation: 10,
                              child: Table(
                                border: TableBorder.all(color: Colors.grey),
                                children: [
                                  TableRow(
                                    decoration: BoxDecoration(color: AzulApp),
                                    children: [
                                      acta == "REGIONAL"
                                          ? cabezeraTableRegional(
                                              style4, responsive)
                                          : acta == "DISTRITAL"
                                              ? cabezeraTablaDistrital(
                                                  responsive, style4)
                                              : cabezeraTableProvincial(
                                                  responsive, style4),
                                    ],
                                  ),
                                  if (snapshot.hasData == true)
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: data,
                                              itemBuilder: (context, index) {
                                                //prueba.clear();
                                                _controllersVotos.add(
                                                    TextEditingController());
                                                _controllersVotosConsejero.add(
                                                    TextEditingController());
                                                var partido =
                                                    snapshot.data![index];
                                                var idPartido =
                                                    partido.idpartidopolitico;
                                                Uint8List bytes = base64.decode(
                                                    partido.logo!
                                                        .split(',')
                                                        .last);
                                                int suma = 0;
                                                int sumaConsejero = 0;
                                                String valor = "";
                                                String datosVotos = "";
                                                String datosVotosConsejero = "";

                                                //para acta provincial
                                                valor =
                                                    '{"idpartidopolitico":"$idPartido", "votos":"${_controllersVotos[index].text}"}';
                                                partidoValorController
                                                    .add(valor);

                                                if (_controllersVotos[index]
                                                        .text !=
                                                    "") {
                                                  datosVotos =
                                                      _controllersVotos[index]
                                                          .text;

                                                  listaVotosGobierno
                                                      .add(datosVotos);
                                                  // print(listaVotosGobierno);
                                                  for (num
                                                      in listaVotosGobierno) {
                                                    //print(num);
                                                    suma += int.parse(num);
                                                  }
                                                  print(suma);
                                                  sumaFinal = suma;
                                                  print(sumaFinal);

                                                  DetalleProvincial
                                                      detalleVotosProvincial =
                                                      DetalleProvincial(
                                                    idPartidoPolitico:
                                                        idPartido,
                                                    tVotos: int.parse(
                                                        _controllersVotos[index]
                                                            .text),
                                                  );
                                                  listaDetalleProvincial.add(
                                                      detalleVotosProvincial);
                                                }
                                                votosEmitidos.text =
                                                    sumaFinal.toString();

                                                //para acta regional y distrital

                                                //votos ='{"idPartidoPolitico": $idPartido, "tVotosGobernador":${_controllersVotos[index].text}, "tVotosConsejero":${_controllersVotosConsejero[index].text}}';
                                                //votosConsejeroControlador.add(votos);
                                                if (_controllersVotos[index]
                                                            .text !=
                                                        "" &&
                                                    _controllersVotosConsejero[
                                                                index]
                                                            .text !=
                                                        "") {
                                                  //votos consejero

                                                  datosVotosConsejero =
                                                      _controllersVotosConsejero[
                                                              index]
                                                          .text;
                                                  listaVotosConsejero
                                                      .add(datosVotosConsejero);
                                                  for (num
                                                      in listaVotosConsejero) {
                                                    //print(num);
                                                    sumaConsejero +=
                                                        int.parse(num);
                                                  }
                                                  print(sumaConsejero);
                                                  sumaFinalConsejero =
                                                      sumaConsejero;
                                                  print(sumaFinalConsejero);

                                                  //llena datos del detalle Regional
                                                  for (int i = 0;
                                                      i >=
                                                          snapshot.data!.length;
                                                      i++) {
                                                    if (_controllersVotos[index]
                                                            .text
                                                            .isEmpty ||
                                                        _controllersVotosConsejero[
                                                                index]
                                                            .text
                                                            .isEmpty) {
                                                      _controllersVotos[i]
                                                              .text ==
                                                          "0";
                                                      _controllersVotosConsejero[
                                                                  i]
                                                              .text ==
                                                          "0";
                                                    }
                                                  }
                                                  Detalle detalleRegional = Detalle(
                                                      idPartidoPolitico:
                                                          idPartido,
                                                      tVotosGobernador:
                                                          int.parse(
                                                              _controllersVotos[
                                                                      index]
                                                                  .text),
                                                      tVotosConsejero: int.parse(
                                                          _controllersVotosConsejero[
                                                                  index]
                                                              .text));
                                                  listaDetalleRegional
                                                      .add(detalleRegional);

                                                  //llena datos del detalle distrital
                                                  DetalleDistrital
                                                      detalleDistrital =
                                                      DetalleDistrital(
                                                          idPartidoPolitico:
                                                              idPartido,
                                                          tVotosProv: int.parse(
                                                              _controllersVotos[
                                                                      index]
                                                                  .text),
                                                          tVotosDist: int.parse(
                                                              _controllersVotosConsejero[
                                                                      index]
                                                                  .text));
                                                  listaDetalleDistrital
                                                      .add(detalleDistrital);
                                                }
                                                votosEmitidosConsejero.text =
                                                    sumaFinalConsejero
                                                        .toString();

                                                  
                                                //print(listaDetalle);

                                                return Column(
                                                  children: [
                                                    acta == "REGIONAL" ||
                                                            acta == "DISTRITAL"
                                                        ? mostrarPartidos(
                                                            partido,
                                                            style4,
                                                            bytes,
                                                            index,
                                                            _controllersVotos[
                                                                index],
                                                            context,
                                                            acta.toString(),
                                                            _controllersVotosConsejero[
                                                                index])
                                                        : mostrarPartidos(
                                                            partido,
                                                            style4,
                                                            bytes,
                                                            index,
                                                            _controllersVotos[
                                                                index],
                                                            context,
                                                            acta.toString(),
                                                            TextEditingController(),
                                                          )
                                                  ],
                                                );
                                              }),
                                        )
                                      ],
                                    )
                                  else
                                    TableRow(children: [
                                      Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ]),
                                  acta == "REGIONAL" || acta == "DISTRITAL"
                                      ? votosEmitidosRegionalDistrital(
                                          responsive,
                                          context,
                                          TextEditingController(
                                              text: votosEmitidos.text),
                                          TextEditingController(
                                              text:
                                                  votosEmitidosConsejero.text))
                                      : votosEmitidosProvincial(
                                          responsive,
                                          context,
                                          TextEditingController(
                                              text: votosEmitidos.text))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Table(
                                children: [
                                  TableRow(
                                    children: [
                                      Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text("Observaciones:"),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Material(
                                              elevation: 5,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: TextFormField(
                                                controller: observaciones,
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20.0)),
                                                  ),
                                                ),
                                                maxLines: 3,
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: Text(
                                                    "Nota: Las observaciones no son obligatorias",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                            fontSize: responsive
                                                                .dp(3.4),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        color: AzulApp),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            botonEnviar(
                                listaDetalleRegional,
                                context,
                                listaDetalleDistrital,
                                listaDetalleProvincial,
                                style3),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  TableRow votosEmitidosRegionalDistrital(
      ResponsiveApp responsive,
      BuildContext context,
      TextEditingController controllerVotos1,
      TextEditingController controllerVotos2) {
    return TableRow(
      decoration: BoxDecoration(color: AzulApp),
      children: [
        Row(
          children: [
            SizedBox(
              height: responsive.hp(15),
              width: responsive.wp(60),
              child: Center(
                child: Text(
                  'Total de votos emitidos ',
                  textScaleFactor: 1,
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: responsive.dp(4),
                          fontWeight: FontWeight.bold),
                      color: Colors.white),
                ),
              ),
            ),
            Row(
              children: [
                Center(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(const Size(50, 15)),
                      child: SizedBox(
                        height: responsive.hp(10),
                        width: responsive.wp(10),
                        child: Form(
                          //key: _formKey,
                          child: TextFormField(
                            maxLength: 5,
                            enabled: false,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              counterText: '',
                              counterStyle: TextStyle(fontSize: 0),
                              fillColor: Colors.white,
                            ),
                            cursorColor: Colors.white,
                            cursorHeight: 20,
                            controller: controllerVotos1,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Datos vacios"),
                                ));
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(Size(50, 15)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: SizedBox(
                          height: responsive.hp(10),
                          width: responsive.wp(10),
                          child: Form(
                            //key: _formKey,
                            child: TextFormField(
                              maxLength: 5,
                              enabled: false,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                counterText: '',
                                counterStyle: TextStyle(fontSize: 0),
                                fillColor: Colors.white,
                              ),
                              cursorColor: Colors.white,
                              cursorHeight: 20,
                              controller: controllerVotos2,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Datos vacios"),
                                  ));
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  TableRow votosEmitidosProvincial(ResponsiveApp responsive,
      BuildContext context, TextEditingController controllerVotosEmitidos) {
    return TableRow(
      decoration: BoxDecoration(color: AzulApp),
      children: [
        Row(
          children: [
            SizedBox(
              height: 70,
              width: 150,
              child: Padding(
                padding: EdgeInsets.only(
                  left: responsive.dp(10),
                  top: responsive.dp(4),
                ),
                child: Text(
                  'Total de votos emitidos',
                  textScaleFactor: 1,
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: responsive.dp(4),
                          fontWeight: FontWeight.bold),
                      color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: responsive.dp(30)),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(50, 10)),
                    child: SizedBox(
                      width: 55,
                      height: 45,
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          maxLength: 5,
                          enabled: false,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            counterText: '',
                            counterStyle: TextStyle(fontSize: 0),
                            fillColor: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          cursorHeight: 20,
                          controller: controllerVotosEmitidos,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Datos vacios"),
                              ));
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row cabezeraTableProvincial(ResponsiveApp responsive, TextStyle style4) {
    return Row(
      children: [
        SizedBox(
          height: responsive.hp(10),
          width: responsive.wp(45),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'ORGANIZACIONES ',
                textScaleFactor: 1,
                style: GoogleFonts.lato(textStyle: style4, color: Colors.white),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 60),
          child: SizedBox(
            height: responsive.hp(12),
            width: responsive.wp(20),
            child: Center(
              child: Text(
                'TOTAL VOTOS ',
                textScaleFactor: 1,
                style: GoogleFonts.lato(textStyle: style4, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row cabezeraTableRegional(TextStyle style4, ResponsiveApp responsive) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SizedBox(
            height: 40,
            width: 135,
            child: Center(
              child: Text(
                'ORGANIZACIONES ',
                textScaleFactor: 1,
                style: GoogleFonts.lato(textStyle: style4, color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(
          height: responsive.hp(20),
          width: responsive.wp(30),
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Center(
              child: Text(
                'VOTOS\nGOBERNADOR',
                textAlign: TextAlign.center,
                textScaleFactor: 1,
                style: GoogleFonts.lato(textStyle: style4, color: Colors.white),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: SizedBox(
            height: responsive.hp(20),
            width: responsive.wp(75),
            child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 5),
              child: Center(
                child: Text(
                  'VOTOS\nCONSEJERO',
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                  style:
                      GoogleFonts.lato(textStyle: style4, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row cabezeraTablaDistrital(ResponsiveApp responsive, TextStyle style4) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: responsive.dp(3)),
          child: SizedBox(
            height: responsive.dp(5),
            width: responsive.dp(40),
            child: Center(
              child: Text(
                'ORGANIZACIONES ',
                textScaleFactor: 1,
                style: GoogleFonts.lato(textStyle: style4, color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(
          height: responsive.hp(20),
          width: responsive.wp(30),
          child: Padding(
            padding: EdgeInsets.only(left: responsive.dp(2)),
            child: Center(
              child: Text(
                'VOTOS\nPROVINCIAL',
                textAlign: TextAlign.center,
                textScaleFactor: 1,
                style: GoogleFonts.lato(textStyle: style4, color: Colors.white),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: SizedBox(
            height: responsive.hp(20),
            width: responsive.wp(75),
            child: Padding(
              padding: EdgeInsets.only(right: responsive.dp(2), left: 5),
              child: Center(
                child: Text(
                  'VOTOS\nDISTRITAL',
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                  style:
                      GoogleFonts.lato(textStyle: style4, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding botonEnviar(
      List<Detalle> listaDetalleRegional,
      BuildContext context,
      List<DetalleDistrital> listaDetalleDistrital,
      List<DetalleProvincial> listaDetalleProvincial,
      TextStyle style3) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (() async {
          /*
                                String mostrar = partidoValorController
                                    .where((element) => element != "")
                                    .fold(
                                        "",
                                        (acc, element) =>
                                            acc += "$element\n");
          
                                String mostrarValores =
                                    votosConsejeroControlador
                                        .where((element) => element != "")
                                        .fold(
                                            "",
                                            (acc, element) =>
                                                acc += "$element\n");*/
          acta == 'REGIONAL'
              ? listaDetalleRegional.isNotEmpty
                  ? int.parse(votosEmitidos.text) <= numeroElectores!.toInt() &&
                          int.parse(votosEmitidosConsejero.text) <=
                              numeroElectores!.toInt()
                      ? Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ActaRegional(
                              acta: acta,
                              nombreLocal: nombreLocal,
                              numeroElectores: numeroElectores,
                              numeroMesa: numeroMesa,
                              idMesaVotacion: idMesaVotacion,
                              detalle: listaDetalleRegional,
                              votosEmitidos: votosEmitidos.text,
                              observaciones: observaciones.text,
                              idUbigeo: idUbigeo,
                              verificacionUbigeo: verificacionUbigeo,
                              codigoLocal: codigoLocal,
                            ),
                          ),
                        )
                      //si la suma de los datos ingresados no es igual al total de electores
                      : showMyDialog(context, "Error a ingresar datos",
                          "Valores incorrectos, verifica los valores ingresados")
                  //si los datos de la lista detalle esta vacia
                  : showMyDialog(
                      context, "Error a ingresar datos", "Datos vacios")
              //validacion para provincial y distrital
              : acta == "DISTRITAL"
                  ? listaDetalleDistrital.isNotEmpty
                      ? int.parse(votosEmitidos.text) <=
                                  numeroElectores!.toInt() &&
                              int.parse(votosEmitidosConsejero.text) <=
                                  numeroElectores!.toInt()
                          ? Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ActaDistrital(
                                  acta: acta,
                                  nombreLocal: nombreLocal,
                                  numeroElectores: numeroElectores,
                                  numeroMesa: numeroMesa,
                                  idMesaVotacion: idMesaVotacion,
                                  detalleDistrital: listaDetalleDistrital,
                                  votosEmitidos: votosEmitidos.text,
                                  observaciones: observaciones.text,
                                  verificacionUbigeo: verificacionUbigeo,
                                  idUbigeo: idUbigeo,
                                  codigoLocal: codigoLocal,
                                ),
                              ),
                            )
                          //si la suma de los datos ingresados no es igual al total de electores
                          : showMyDialog(context, "Error a ingresar datos",
                              "Valores incorrectos, verifica los valores ingresados")
                      //si los datos de la lista detalle esta vacia
                      : showMyDialog(
                          context, "Error a ingresar datos", "Datos vacios")
                  : listaDetalleProvincial.isNotEmpty
                      ? int.parse(votosEmitidos.text) <=
                              numeroElectores!.toInt()
                          //si es igual va al siguiente
                          ? Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ActaProvincial(
                                  idMesaVotacion: idMesaVotacion,
                                  acta: acta,
                                  nombreLocal: nombreLocal,
                                  detalleProvincial: listaDetalleProvincial,
                                  votosEmitidos: votosEmitidos.text,
                                  observaciones: observaciones.text,
                                  numeroMesa: numeroMesa,
                                  numeroElectores: numeroElectores,
                                  verificacionUbigeo: verificacionUbigeo,
                                  idUbigeo: idUbigeo,
                                  codigoLocal: codigoLocal,
                                ),
                              ),
                            )
                          //si es falso ingresa datos de nuevo
                          : showMyDialog(context, "Error a ingresar datos",
                              "Valores incorrectos, verifica los valores ingresados")
                      : showMyDialog(
                          context, "Error a ingresar datos", "Datos vacios");
        }),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 30,
            width: 100,
            decoration: BoxDecoration(
              color: AzulApp,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                "ENVIAR",
                style: GoogleFonts.lato(
                  textStyle: style3,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
