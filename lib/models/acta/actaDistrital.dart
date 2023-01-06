import 'dart:convert';

import 'package:api/models/detalle/detalleDistrital.dart';

ActaDistritalModelo actaFromJson(String str) => ActaDistritalModelo.fromJson(json.decode(str));

String actaToJson(ActaDistritalModelo data) => json.encode(data.toJson());

class ActaDistritalModelo {
    ActaDistritalModelo({
         this.idMesaVotacion,
         this.imagen,
         this.observaciones,
         this.detalle,
    });

     int? idMesaVotacion;
     String? imagen;
     String? observaciones;
     List<DetalleDistrital>? detalle;

    factory ActaDistritalModelo.fromJson(Map<String, dynamic> json) => ActaDistritalModelo(
        idMesaVotacion: json["idMesaVotacion"],
        imagen: json["imagen"],
        observaciones: json["observaciones"],
        detalle: List<DetalleDistrital>.from(json["detalle"].map((x) => DetalleDistrital.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "idMesaVotacion": idMesaVotacion,
        "imagen": imagen,
        "observaciones": observaciones,
        "detalle": List<dynamic>.from(detalle!.map((x) => x.toJson())),
    };
}

