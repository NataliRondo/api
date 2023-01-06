// ignore_for_file: use_key_in_widget_constructors, use_build_context_synchronously

import 'dart:convert';
import 'dart:math';
import 'package:api/api/servicio_personero.dart';
import 'package:api/api/servicio_soporte.dart';
import 'package:api/models/local.dart';
import 'package:api/models/soporte.dart';
import 'package:api/models/token.dart';
import 'package:api/models/usuario.dart';
import 'package:api/utils/session.dart';
import 'package:api/widgets/boton_soporte.dart';
import 'package:api/widgets/colores.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserView extends StatefulWidget {
  const UserView({this.item});

  final Usuario? item;

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  Usuario usuario = Usuario();
  Token token = Token();
  ServicePersonero servicio = ServicePersonero();
  Local local = Local();
  ServicioSoporte servicioSoporte = ServicioSoporte();
  //
  
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
    String apellido = '${usuario.perApPaterno} ${usuario.perApMaterno}';
    String dni = usuario.perDni.toString();
    String celular = usuario.perCelular.toString();
    //String direccion = usuario.perDireccion.toString();
    var inicial = nombre.substring(0, 1).toString().toUpperCase();
    var colorRandom =
        Colors.primaries[Random().nextInt(Colors.primaries.length)];

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AzulApp,
            ),
            child: UserAccountsDrawerHeader(
              currentAccountPictureSize: const Size.square(45),
              currentAccountPicture: CircleAvatar(
                backgroundColor: colorRandom,
                child: Text(
                  inicial,
                  style: const TextStyle(fontSize: 30.0, color: Colors.black),
                ), //Text
              ), //
              decoration: BoxDecoration(
                color: AzulApp,
              ),
              accountEmail: Container(
                child: Text(
                  '',
                ),
              ),
              accountName: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 80,
                  child: Center(
                    child: Text(
                      '$nombre\n$apellido',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(fontSize: 15)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    "DNI: $dni",
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        color: AzulApp),
                  ),
                ),
                ListTile(
                  title: Text(
                    "CELULAR: $celular",
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        color: AzulApp),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Contáctanos: ",
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            color: AzulApp),
                      ),
                    ),
                    FutureBuilder(
                      future: servicioSoporte.getSoporte(),
                      builder:
                          ((context, AsyncSnapshot<List<Soporte>> snapshot) {
                        if (snapshot.hasData) {
                          List<Soporte>? soporteLista = snapshot.data;
                          return SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 35),
                              child: ListView(
                                shrinkWrap: true,
                                children: soporteLista!
                                    .map(
                                      (Soporte soporte) => botonSoporte(
                                          context,
                                          soporte.nombre,
                                          soporte.celular,
                                          "Hola ${soporte.nombre}, soy $nombre $apellido"),
                                    )
                                    .toList(),
                              ),
                            ),
                          );
                        } else {
                          return const Text("");
                        }
                      }),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Cerrar Sesión',
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                            color: AzulApp),
                      ),
                      onTap: () async {
                        await cerrarSesion(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  
}
