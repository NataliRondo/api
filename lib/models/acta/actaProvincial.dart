import 'dart:convert';

import 'package:api/models/detalle/detalleProvincial.dart';

ActaProvincialModelo actaFromJson(String str) => ActaProvincialModelo.fromJson(json.decode(str));

String actaToJson(ActaProvincialModelo data) => json.encode(data.toJson());

class ActaProvincialModelo {
    ActaProvincialModelo({
         this.idMesaVotacion,
         this.imagen,
         this.observaciones,
         this.detalle,
    });

     int? idMesaVotacion;
     String? imagen;
     String? observaciones;
     List<DetalleProvincial>? detalle;

    factory ActaProvincialModelo.fromJson(Map<String, dynamic> json) => ActaProvincialModelo(
        idMesaVotacion: json["idMesaVotacion"],
        imagen: json["imagen"],
        observaciones: json["observaciones"],
        detalle: List<DetalleProvincial>.from(json["detalle"].map((x) => DetalleProvincial.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "idMesaVotacion": idMesaVotacion,
        "imagen": imagen,
        "observaciones": observaciones,
        "detalle": List<dynamic>.from(detalle!.map((x) => x.toJson())),
    };
}

