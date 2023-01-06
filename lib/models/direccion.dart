
import 'dart:convert';

Direccion direccionFromJson(String str) => Direccion.fromJson(json.decode(str));

String direccionToJson(Direccion data) => json.encode(data.toJson());

class Direccion {
    Direccion({
        this.idUbigeo,
       this.departamento,
        this.provincia,
        this.distrito,
        this.ubigeoReniec,
        this.ubigeoInei,
        this.codDepartamentoR,
        this.codDepartamentoI,
        this.codProvinciaR,
        this.codProvinciaI,
        this.codDistritoR,
        this.codDistritoI,
        this.macroregionInei,
        this.macroregionMinsa,
        this.iso31662,
        this.latitud,
        this.longitud,
        this.descripcion,
    });

     int? idUbigeo;
     String? departamento;
     String? provincia;
     dynamic distrito;
     String? ubigeoReniec;
     String? ubigeoInei;
     String? codDepartamentoR;
     String? codDepartamentoI;
     String? codProvinciaR;
     String? codProvinciaI;
     String? codDistritoR;
     String? codDistritoI;
     dynamic macroregionInei;
     dynamic macroregionMinsa;
     String? iso31662;
     String? latitud;
     String? longitud;
     String? descripcion;

    factory Direccion.fromJson(Map<String, dynamic> json) => Direccion(
        idUbigeo: json["idUbigeo"],
        departamento: json["departamento"],
        provincia: json["provincia"],
        distrito: json["distrito"],
        ubigeoReniec: json["ubigeoReniec"],
        ubigeoInei: json["ubigeoINEI"],
        codDepartamentoR: json["codDepartamentoR"],
        codDepartamentoI: json["codDepartamentoI"],
        codProvinciaR: json["codProvinciaR"],
        codProvinciaI: json["codProvinciaI"],
        codDistritoR: json["codDistritoR"],
        codDistritoI: json["codDistritoI"],
        macroregionInei: json["macroregion_inei"],
        macroregionMinsa: json["macroregion_minsa"],
        iso31662: json["iso_3166_2"],
        latitud: json["latitud"],
        longitud: json["longitud"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "idUbigeo": idUbigeo,
        "departamento": departamento,
        "provincia": provincia,
        "distrito": distrito,
        "ubigeoReniec": ubigeoReniec,
        "ubigeoINEI": ubigeoInei,
        "codDepartamentoR": codDepartamentoR,
        "codDepartamentoI": codDepartamentoI,
        "codProvinciaR": codProvinciaR,
        "codProvinciaI": codProvinciaI,
        "codDistritoR": codDistritoR,
        "codDistritoI": codDistritoI,
        "macroregion_inei": macroregionInei,
        "macroregion_minsa": macroregionMinsa,
        "iso_3166_2": iso31662,
        "latitud": latitud,
        "longitud": longitud,
        "descripcion": descripcion,
    };
}
