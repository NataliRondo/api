// ignore_for_file: file_names, unrelated_type_equality_checks

import 'package:api/api/servicio_acta.dart';
import 'package:api/utils/responsive.dart';
import 'package:api/widgets/colores.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget cardBotones(
    BuildContext context,
    String acta,
    String? numeroMesa,
    int? numeroElectores,
    int? idMesaVotacion,
    String? verificacionUbigeo,
    String? nombreLocal,
    int? ubigeo, int? codigoLocal) {
  ServicioActa servicioActa = ServicioActa();
  const style = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  //Color? colorCard = Color.fromARGB(96, 171, 235, 198);

  ResponsiveApp responsive = ResponsiveApp(context);
  return Container(
    padding: const EdgeInsets.all(20),
    child: Column(
      children: [
        Card(
          elevation: 3,
          child: InkWell(
            onTap: () async {
              switch (acta) {
                case 'DISTRITAL':
                  servicioActa.verificarActaDistrital(
                      acta.toString(),
                      numeroMesa,
                      numeroElectores,
                      idMesaVotacion,
                      context,
                      verificacionUbigeo,
                      nombreLocal,
                      ubigeo, codigoLocal);

                  break;
                case 'PROVINCIAL':
                  servicioActa.verificarActaProvincial(
                      acta.toString(),
                      numeroMesa,
                      numeroElectores,
                      idMesaVotacion,
                      context,
                      verificacionUbigeo,
                      nombreLocal,
                      ubigeo, codigoLocal);

                  break;
                case 'REGIONAL':
                  servicioActa.verificarActaRegional(
                      acta.toString(),
                      numeroMesa,
                      numeroElectores,
                      idMesaVotacion,
                      context,
                      verificacionUbigeo,
                      nombreLocal,
                      ubigeo, codigoLocal);
                  /*Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PartidosView(
                        numeroMesa: numeroMesa,
                        numeroElectores: numeroElectores,
                        acta: acta.toString(),
                        idMesaVotacion: idMesaVotacion,
                      ),
                    ),
                  ); */
                  break;
                default:
              }
            },
            child: Container(
              width: responsive.wp(90),
              height: responsive.hp(20),
              child: Row(
                children: [
                  SizedBox(
                    width: responsive.wp(60),
                    height: responsive.hp(20),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: responsive.dp(5),
                          bottom: responsive.dp(5),
                          left: responsive.dp(25)),
                      child: Center(
                        child: Text(
                          acta,
                          textScaleFactor: 1,
                          style: GoogleFonts.lato(
                              textStyle: style, color: AzulApp),
                        ),
                      ),
                    ),
                  ),
                  /*  Padding(
                    padding: EdgeInsets.only(left: responsive.dp(15)),
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      height: responsive.hp(20),
                      width: responsive.wp(10),
                    ),
                  ),*/
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
/**
 * Container(
              width: responsive.wp(80),
              height: responsive.hp(20),
              child: Row(
                children: [
                  SizedBox(
                    width: responsive.wp(55),
                    height: responsive.hp(20),
                    child: Padding(
                      padding: EdgeInsets.only(top: responsive.dp(5), bottom: responsive.dp(5), left: responsive.dp(25)),
                      child: Center(
                        child: Text(
                          acta,
                          textScaleFactor: 1,
                          style:
                              GoogleFonts.lato(textStyle: style, color: AzulApp),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: responsive.dp(15)),
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      height: responsive.hp(20),
                      width: responsive.wp(10),
                      decoration: BoxDecoration(color: colorCard),
                    ),
                  ),
                ],
              ),
            ),
 * 
*/