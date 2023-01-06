// ignore_for_file: avoid_print, file_names

import 'package:flutter/material.dart';

Widget cajaTexto(String? votosPartido) {
  return Padding(
    padding: const EdgeInsets.only(right: 25, left: 25),
    child: Center(
      child: FittedBox(
        fit: BoxFit.cover,
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(const Size(30, 10)),
            child: SizedBox(
              width: 45,
              height: 45,
              child: TextFormField(
                cursorHeight: 20,
                onChanged: (textopartido) {
                  votosPartido = textopartido;
                  print(votosPartido);
                },
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
