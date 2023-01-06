// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  int? perCodigo;
  String? perDni;
  String? perNombre;
  String? perApPaterno;
  String? perApMaterno;
  String? perCelular;
  String? perCorreo;
  String? perContrasena;
  String? perUsuario;
  String? perTUsuario;
  String? token;
  //Map<String, int>? perDireccion;
  
  Usuario({
    this.perCodigo,
    this.perDni,
    this.perNombre,
    this.perApPaterno,
    this.perApMaterno,
    this.perCelular,
    this.perCorreo,
    this.perContrasena,
    this.perUsuario,
    this.perTUsuario,
    this.token,
    //this.perDireccion,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        perCodigo: json["PerCodigo"],
        perDni: json["PerDni"],
        perNombre: json["PerNombre"],
        perApPaterno: json["PerApPaterno"],
        perApMaterno: json["PerApMaterno"],
        perCelular: json["PerCelular"],
        perCorreo: json["PerCorreo"],
        perContrasena: json["PerContrasena"],
        perUsuario: json["PerUsuario"],
        perTUsuario: json["PerTUsuario"],
        token: json["Token"],
        //perDireccion: Map.from(json["PerDireccion"]).map((k, v) => MapEntry<String, int>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "PerCodigo": perCodigo,
        "PerDni": perDni,
        "PerNombre": perNombre,
        "PerApPaterno": perApPaterno,
        "PerApMaterno": perApMaterno,
        "PerCelular": perCelular,
        "PerCorreo": perCorreo,
        "PerContrasena": perContrasena,
        "PerUsuario": perUsuario,
        "PerTUsuario": perTUsuario,
        "Token": token,
        //"PerDireccion": Map.from(perDireccion!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
