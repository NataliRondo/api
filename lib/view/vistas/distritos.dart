import 'package:api/utils/responsive.dart';
import 'package:api/utils/variables.dart';
import 'package:api/widgets/buscarMesaWidget.dart';
import 'package:api/widgets/colores.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

Distritos(GlobalKey<FormState> keyForm, ResponsiveApp responsive,
    TextEditingController buscarMesa, String provincia, BuildContext context) {
  return Column(
    children: [
      Table(
        children: [
          TableRow(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 245, left: 20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 60),
                          child: Container(
                            width: 30,
                            height: 7,
                            color: RojoApp,
                            //padding: EdgeInsets.only(left: 1),
                            alignment: Alignment.topLeft,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Busca tu mesa',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.lato(
                                textStyle: style, color: AzulApp),
                          ),
                        ),
                        /*Text(
                          '$provincia',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lato(
                              textStyle: style, color: AzulApp),
                        ),*/
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          TableRow(
            children: [
              Column(
                children: [
                  SizedBox(height: responsive.dp(4)),
                  
                  buscar(
                      buscarMesa, RojoApp, responsive.dp(15), keyForm, context),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
