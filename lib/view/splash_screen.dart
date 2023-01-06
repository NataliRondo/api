// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:api/api/servicio_login.dart';
import 'package:api/models/token.dart';
import 'package:api/models/usuario.dart';
import 'package:api/utils/session.dart';
import 'package:api/view/login/login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Usuario usuario = Usuario();
  Token token = Token();
  ServicioLogin login = ServicioLogin();

  bool _isLoaded = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 700),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isLoaded = true;
          FocusScope.of(context).requestFocus(FocusNode());
        });
      }
    });
    setState(() {
      CerrarSesionUsuario(context);
    });
    super.initState();
    //getCred();
    checkLogin();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  void getCred() async {
    await datosGuardados();
  }

  Future<void> datosGuardados() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      List<String>? extra = pref.getStringList("usuario")!.toList();
      usuario = Usuario.fromJson(json.decode(extra[0].toString()));
      token = Token.fromJson(json.decode(extra[1].toString()));
    });
  }

  Future<void> checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? sesion = pref.getStringList("usuario");
    if (sesion != null) {
      token = Token.fromJson(json.decode(sesion[1].toString()));
      DateTime currentDate = DateTime.now();
      DateTime? tokeninicio = token.inicio;
      int? tokenVencimiento = int.parse(token.vencimiento.toString());
      int diff = currentDate.difference(tokeninicio!).inMinutes;
      var resta = tokenVencimiento - diff;
      if (resta > 1) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/distritos', (route) => false);
      } 
      else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoaded
            ? LoginPage()
            : Lottie.asset('assets/screen.json', controller: _controller,
                onLoaded: (comp) {
                _controller.duration = comp.duration;
                _controller.forward();
              }),
      ),
    );
  }
}
