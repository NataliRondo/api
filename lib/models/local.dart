import 'dart:convert';

Local localFromJson(String str) => Local.fromJson(json.decode(str));

String localToJson(Local data) => json.encode(data.toJson());

class Local {
    Local({
         this.idLocalVotacion,
         this.codLocalVotacion,
         this.nombreLocal,
         this.direccion,
         this.referencia,
         this.idUbigeo,
    });

     int? idLocalVotacion;
     String? codLocalVotacion;
     String? nombreLocal;
     String? direccion;
     String? referencia;
     int? idUbigeo;

    factory Local.fromJson(Map<String, dynamic> json) => Local(
        idLocalVotacion: json["idLocalVotacion"],
        codLocalVotacion: json["codLocalVotacion"],
        nombreLocal: json["nombreLocal"],
        direccion: json["direccion"],
        referencia: json["referencia"],
        idUbigeo: json["idUbigeo"],
    );

    Map<String, dynamic> toJson() => {
        "idLocalVotacion": idLocalVotacion,
        "codLocalVotacion": codLocalVotacion,
        "nombreLocal": nombreLocal,
        "direccion": direccion,
        "referencia": referencia,
        "idUbigeo": idUbigeo,
    };
    /*
    factory Local.fromJsonInt(Map<int, dynamic> json) => Local(
        idLocalVotacion: json["idLocalVotacion"],
        codLocalVotacion: json["codLocalVotacion"],
        nombreLocal: json["nombreLocal"],
        direccion: json["direccion"],
        referencia: json["referencia"],
        idUbigeo: json["idUbigeo"],
    );
    */
}
