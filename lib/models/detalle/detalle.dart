import 'dart:convert';

List<Detalle> detalleFromJson(String str) =>
    List<Detalle>.from(json.decode(str).map((x) => Detalle.fromJson(x)));

String detalleToJson(List<Detalle> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Detalle {
  Detalle({
    this.idPartidoPolitico,
    this.tVotosGobernador,
    this.tVotosConsejero,
  });

  int? idPartidoPolitico;
  int? tVotosGobernador;
  int? tVotosConsejero;

  factory Detalle.fromJson(Map<String, dynamic> json) => Detalle(
        idPartidoPolitico: json["idPartidoPolitico"],
        tVotosGobernador: json["tVotosGobernador"],
        tVotosConsejero: json["tVotosConsejero"],
      );

  Map<String, dynamic> toJson() => {
        "idPartidoPolitico": idPartidoPolitico,
        "tVotosGobernador": tVotosGobernador,
        "tVotosConsejero": tVotosConsejero,
      };
}
