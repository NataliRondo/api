// ignore_for_file: file_names

import 'package:api/api/servicio_mesa.dart';

import '../utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget cardMesas(
    BuildContext context,
    Color color,
    String numeroMesa,
    String porcentaje,
    int? numeroElectores,
    int? idMesaVotacion,
    int? codigoLocal,
    String? nombreLocal,
    int? idUbigeo) {
  ResponsiveApp responsive = ResponsiveApp(context);
  ServicioMesa servicioMesa = ServicioMesa();
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: InkWell(
      onTap: () {
        servicioMesa.validarMesa(
            idUbigeo,
            context,
            color,
            numeroMesa,
            porcentaje,
            numeroElectores,
            idMesaVotacion,
            codigoLocal,
            nombreLocal, 
            );
      },
      splashColor: const Color.fromARGB(94, 68, 164, 243),
      child: Container(
        width: 350,
        height: 150,
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 60,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Image(
                  fit: BoxFit.cover,
                  image: const AssetImage('assets/mesa-votacion-2.png'),
                  color: color,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: responsive.wp(35),
                  height: responsive.hp(7),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        'Mesa: $numeroMesa',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.lato(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80,
              width: responsive.wp(30),
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Center(
                  child: Text(
                    '',
                    //'$porcentaje\n Completo',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      fontSize: responsive.dp(responsive.isTablet ? 1.5 : 3.5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
