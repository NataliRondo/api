import 'dart:convert';

Partido partidoFromJson(String str) => Partido.fromJson(json.decode(str));

String partidoToJson(Partido data) => json.encode(data.toJson());

class Partido {
    Partido({
         this.idpartidopolitico,
         this.denominacion,
         this.logo,
         this.tipoAgrupacion,
         this.auxOrden,
    });

     int? idpartidopolitico;
     String? denominacion;
     String? logo;
     String? tipoAgrupacion;
     int? auxOrden;

    factory Partido.fromJson(Map<String, dynamic> json) => Partido(
        idpartidopolitico: json["idpartidopolitico"],
        denominacion: json["denominacion"],
        logo: json["logo"],
        tipoAgrupacion: json["tipoAgrupacion"],
        auxOrden: json["auxOrden"],
    );

    Map<String, dynamic> toJson() => {
        "idpartidopolitico": idpartidopolitico,
        "denominacion": denominacion,
        "logo": logo,
        "tipoAgrupacion": tipoAgrupacion,
        "auxOrden": auxOrden,
    };
}
