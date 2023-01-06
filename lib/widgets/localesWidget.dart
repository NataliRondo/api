import 'package:api/models/local.dart';
import 'package:api/widgets/cardLocales.dart';
import 'package:api/widgets/colores.dart';
import 'package:flutter/material.dart';

Column listaLocales(List<Local> locales, BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: locales
              .map(
                (Local local) => cardLocales(
                    context,
                    RojoApp,
                    local.idLocalVotacion!.toInt(),
                    local.nombreLocal.toString(),
                    local.direccion.toString(),
                    local.referencia.toString(),
                    "",
                    local.idUbigeo),
              )
              .toList(),
        ),
      ),
    ],
  );
}
