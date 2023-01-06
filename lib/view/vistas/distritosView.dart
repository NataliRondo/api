import 'dart:convert';

import 'package:api/api/servicio_personero.dart';
import 'package:api/models/direccion.dart';
import 'package:api/models/local.dart';
import 'package:api/models/token.dart';
import 'package:api/models/usuario.dart';
import 'package:api/utils/responsive.dart';
import 'package:api/utils/session.dart';
import 'package:api/view/user_view.dart';
import 'package:api/view/vistas/distritos.dart';
import 'package:api/widgets/colores.dart';
import 'package:api/widgets/localesWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DistritosView extends StatefulWidget {
  DistritosView({Key? key}) : super(key: key);

  @override
  State<DistritosView> createState() => _DistritosViewState();
}

class _DistritosViewState extends State<DistritosView> {
  Usuario usuario = Usuario();
  Token token = Token();
  Direccion direccion = Direccion();
  GlobalKey<ScaffoldState> keyScaffold = GlobalKey();
  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController buscarMesa = TextEditingController();
  ServicePersonero servicio = ServicePersonero();

  getCred() async {
    await sesionUsuario();
  }

  Future<void> sesionUsuario() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      List<String>? extra = pref.getStringList("usuario")!.toList();
      usuario = Usuario.fromJson(json.decode(extra[0].toString()));
      token = Token.fromJson(json.decode(extra[1].toString()));
      direccion = Direccion.fromJson(json.decode(extra[2].toString()));
    });
  }

  @override
  void initState() {
    setState(() {
      CerrarSesionUsuario(context);
    });
    super.initState();
    getCred();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsive = ResponsiveApp(context);
    String nombre = usuario.perNombre.toString();
    int? codigo = usuario.perCodigo;
    String? provincia = direccion.provincia;
    return Scaffold(
      key: keyScaffold,
      endDrawer: const UserView(),
      appBar: AppBar(
        backgroundColor: FondoApp,
        flexibleSpace: Container(
          decoration: BoxDecoration(color: AzulApp),
        ),
        title: Text(
          "Hola, " + nombre,
          textAlign: TextAlign.right,
          style: GoogleFonts.lato(
            fontSize: responsive.dp(responsive.isTablet ? 2 : 5),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            icon: const Icon(
              Icons.person,
            ),
            onPressed: () async {
              keyScaffold.currentState!.openEndDrawer();
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              //FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              children: [
                Distritos(keyForm, responsive, buscarMesa, provincia.toString(),
                    context),
                ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    FutureBuilder(
                      future: servicio.getLocales(codigo),
                      builder: ((context, AsyncSnapshot<List<Local>> snapshot) {
                        if (snapshot.hasData) {
                          List<Local>? locales = snapshot.data;
                          return Column(
                            children: [
                              Table(
                                children: [
                                  //lista de locales
                                  TableRow(
                                    children: [
                                      Column(
                                        children: [
                                          listaLocales(locales!, context),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else {
                          //cerrarSesion(context);
                          return Padding(
                            padding: const EdgeInsets.all(15),
                            child: const Center(
                                child: CircularProgressIndicator()),
                          );
                        }
                      }),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
