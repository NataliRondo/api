import 'dart:convert';

Token tokenFromJson(String str) => Token.fromJson(json.decode(str));
String tokenToJson(Token data) => json.encode(data.toJson());

class Token {
    Token({
        this.token,
        this.vencimiento,
        this.inicio,
    });

     String? token;
     String? vencimiento;
     DateTime? inicio;

    factory Token.fromJson(Map<String, dynamic> json) => Token(
        token: json["token"],
        vencimiento: json["vencimiento"],
        inicio: DateTime.parse(json["inicio"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "vencimiento": vencimiento,
        "inicio": inicio!.toIso8601String(),
    };
}