// ignore_for_file: file_names

import 'package:api/utils/responsive.dart';
import 'package:api/view/vistas/mesas.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget cardLocales(BuildContext context, Color color, int idLocal, String local,
    String direccion, String referencia, String porcentaje, int? idUbigeo) {
  ResponsiveApp responsive = ResponsiveApp(context);
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Mesas(
              codigoLocal: idLocal,
              nombreLocal: local,
              idUbigeo: idUbigeo,
              
            ),
          ),
        );

        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(          content: Text(idLocal),        ));
      },
      splashColor: const Color.fromARGB(94, 68, 164, 243),
      child: Container(
        width: responsive.wp(100),
        height: responsive.hp(45),
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Image(
                  fit: BoxFit.cover,
                  image: const AssetImage('assets/edificio.png'),
                  color: color,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: responsive.wp(45),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        local,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.lato(
                          fontSize:
                              responsive.dp(responsive.isTablet ? 1.5 : 4),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        direccion,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.lato(
                          fontSize:
                              responsive.dp(responsive.isTablet ? 1.5 : 4),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        referencia,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.lato(
                          fontSize:
                              responsive.dp(responsive.isTablet ? 1.5 : 4),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80,
              width: responsive.wp(25),
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Center(
                  child: Text(
                    '$porcentaje',
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
