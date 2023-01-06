import 'dart:convert';

import 'package:api/models/detalle/detalle.dart';

ActaRegionalModelo actaFromJson(String str) => ActaRegionalModelo.fromJson(json.decode(str));

String actaToJson(ActaRegionalModelo data) => json.encode(data.toJson());

class ActaRegionalModelo {
    ActaRegionalModelo({
         this.idMesaVotacion,
         this.imagen,
         this.observaciones,
         this.detalle,
    });

     int? idMesaVotacion;
     String? imagen;
     String? observaciones;
     List<Detalle>? detalle;

    factory ActaRegionalModelo.fromJson(Map<String, dynamic> json) => ActaRegionalModelo(
        idMesaVotacion: json["idMesaVotacion"],
        imagen: json["imagen"],
        observaciones: json["observaciones"],
        detalle: List<Detalle>.from(json["detalle"].map((x) => Detalle.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "idMesaVotacion": idMesaVotacion,
        "imagen": imagen,
        "observaciones": observaciones,
        "detalle": List<dynamic>.from(detalle!.map((x) => x.toJson())),
    };
}

