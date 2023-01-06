// ignore_for_file: file_names

import 'dart:convert';
import 'dart:typed_data';

import 'package:api/utils/responsive.dart';
import 'package:api/widgets/colores.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget tablaPartidos(BuildContext context, int? numero, String? denominacion,
    String? imagen, TextField textField) {
  ResponsiveApp responsive = ResponsiveApp(context);
  var style =
      TextStyle(fontSize: responsive.dp(4), fontWeight: FontWeight.bold);
  Uint8List bytes = base64.decode(imagen!.split(',').last);

  return Table(
    children: [
      TableRow(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Text(
                        numero.toString(),
                        style:
                            GoogleFonts.lato(textStyle: style, color: AzulApp),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        width: 140,
                        child: Text(
                          denominacion.toString(),
                          style: GoogleFonts.lato(
                              textStyle: style, color: AzulApp),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: imagen != ""
                          ? Image.memory(
                              bytes,
                              scale: 0.1,
                            )
                          : const SizedBox(
                              child: Text(""),
                            ),
                    ),
                    Padding(
                      padding:  const EdgeInsets.only(right: 25, left: 25),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Padding(
                            padding:  const EdgeInsets.all(9.0),
                            child: ConstrainedBox(
                              constraints:
                                  BoxConstraints.tight( const Size(30, 10)),
                              child: SizedBox(
                                width: 45,
                                height: 45,
                                child: textField,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}
