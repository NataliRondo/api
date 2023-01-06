// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:api/models/direccion.dart';
import 'package:api/models/token.dart';
import 'package:api/models/usuario.dart';
import 'package:api/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServicioLogin {
  
  Future<Usuario> login(String passController, String usernameController, String direccionip,
      BuildContext context) async {
    return http.post(Uri.parse("$uri/api/login/authenticate"), body: {
      'username': usernameController,
      'password': passController,
      'app': 'movil',
      'osInfo': 'movil',
      'clienteInfo': 'movil',
      'Direccionip': direccionip,
      'key': 'greymon'
    }).then((dynamic res) {
      final Map<String, dynamic> body = jsonDecode(res.body);
      Token token = Token();
      Usuario usuario = Usuario();
      Direccion direccion = Direccion();
      if (passController.isNotEmpty && usernameController.isNotEmpty) {
        if (body["Status"] == "Success") {
          usuario = Usuario.fromJson(body["Data"]);
          token = Token.fromJson(body["Resultado"]);
          direccion = Direccion.fromJson(body["Data"]["PerDireccion"]);
          Map<String, dynamic> usuarioJson = usuario.toJson();
          Map<String, dynamic> tokenJson = token.toJson();
          Map<String, dynamic> direccionJson = direccion.toJson();

          String usuarioEncode = json.encode(usuarioJson);
          String tokenEncode = json.encode(tokenJson);
          String direccionEncode = json.encode(direccionJson);

          //List<String> datos;
          //datos = [usuarioEncode, tokenEncode];
          //pageRoute(datos, context);
          pageRoute([usuarioEncode, tokenEncode, direccionEncode], context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Credenciales inválidas"),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Datos vacios"),
          ),
        );
      }
      return usuario;
    });
  }

  void pageRoute(List<String> usuario, BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setStringList("usuario", usuario);
    Navigator.pushNamedAndRemoveUntil(context, '/distritos', (route) => false);
  }

  
}
