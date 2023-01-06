import 'dart:convert';

Mesa mesaFromJson(String str) => Mesa.fromJson(json.decode(str));

String mesaToJson(Mesa data) => json.encode(data.toJson());

class Mesa {
    Mesa({
         this.idMesaVotacion,
         this.nroMesa,
         this.idLocalVotacion,
         this.tElectroesHabiles,
         this.auxCodProvinciaR

    });

     int? idMesaVotacion;
     String? nroMesa;
     int? idLocalVotacion;
     int? tElectroesHabiles;
     String? auxCodProvinciaR;

    factory Mesa.fromJson(Map<String, dynamic> json) => Mesa(
        idMesaVotacion: json["idMesaVotacion"],
        nroMesa: json["nroMesa"],
        idLocalVotacion: json["idLocalVotacion"],
        tElectroesHabiles: json["tElectroesHabiles"],
        auxCodProvinciaR : json["auxCodProvinciaR"]
    );

    Map<String, dynamic> toJson() => {
        "idMesaVotacion": idMesaVotacion,
        "nroMesa": nroMesa,
        "idLocalVotacion": idLocalVotacion,
        "tElectroesHabiles": tElectroesHabiles,
        "auxCodProvinciaR": auxCodProvinciaR
    };
}
