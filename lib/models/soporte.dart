import 'dart:convert';

Soporte soporteFromJson(String str) => Soporte.fromJson(json.decode(str));

String soporteToJson(Soporte data) => json.encode(data.toJson());

class Soporte {
  Soporte({
    this.id,
    this.nombre,
    this.celular,
  });

  int? id;
  String? nombre;
  String? celular;

  factory Soporte.fromJson(Map<String, dynamic> json) => Soporte(
        id: json["id"],
        nombre: json["nombre"],
        celular: json["celular"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "celular": celular,
      };
}
