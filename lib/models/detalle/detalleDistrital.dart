import 'dart:convert';

List<DetalleDistrital> detalleDistritalFromJson(String str) => List<DetalleDistrital>.from(json.decode(str).map((x) => DetalleDistrital.fromJson(x)));

String detalleDistritalToJson(List<DetalleDistrital> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DetalleDistrital {
    DetalleDistrital({
        this.idPartidoPolitico,
         this.tVotosProv,
         this.tVotosDist,
    });

     int? idPartidoPolitico;
     int? tVotosProv;
     int? tVotosDist;

    factory DetalleDistrital.fromJson(Map<String, dynamic> json) => DetalleDistrital(
        idPartidoPolitico: json["idPartidoPolitico"],
        tVotosProv: json["tVotosProv"],
        tVotosDist: json["tVotosDist"],
    );

    Map<String, dynamic> toJson() => {
        "idPartidoPolitico": idPartidoPolitico,
        "tVotosProv": tVotosProv,
        "tVotosDist": tVotosDist,
    };
}