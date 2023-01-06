import 'dart:convert';

List<DetalleProvincial> detalleProvincialFromJson(String str) => List<DetalleProvincial>.from(json.decode(str).map((x) => DetalleProvincial.fromJson(x)));

String detalleProvincialToJson(List<DetalleProvincial> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DetalleProvincial {
    DetalleProvincial({
         this.idPartidoPolitico,
         this.tVotos,
    });

     int? idPartidoPolitico;
     int? tVotos;

    factory DetalleProvincial.fromJson(Map<String, dynamic> json) => DetalleProvincial(
        idPartidoPolitico: json["idPartidoPolitico"],
        tVotos: json["tVotos"],
    );

    Map<String, dynamic> toJson() => {
        "idPartidoPolitico": idPartidoPolitico,
        "tVotos": tVotos,
    };
}
