import 'package:api/utils/open_whatsaap.dart';
import 'package:api/widgets/colores.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget botonSoporte(BuildContext context, String? nombre, String? celular, String? mensaje) {
  return InkWell(
    child: Row(
      children: [
        Text(
          nombre.toString(),
          style: GoogleFonts.lato(
              textStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              color: AzulApp),
        ),
        IconButton(
          onPressed: () {
            openwhatsapp(context, "$celular", mensaje.toString());
          },
          icon: Icon(
            Icons.whatsapp,
            color: Whatsapp,
          ),
        ),
      ],
    ),
  );
}
