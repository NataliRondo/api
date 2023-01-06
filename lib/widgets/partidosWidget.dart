// ignore_for_file: must_be_immutable, file_names
import 'dart:typed_data';
import 'package:api/utils/responsive.dart';
import 'package:api/utils/variables.dart';
import 'package:api/widgets/colores.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Table mostrarPartidos(
    partido,
    TextStyle style,
    Uint8List bytes,
    int index,
    TextEditingController controller,
    BuildContext context,
    String acta,
    TextEditingController controllerConsejero) {
  ResponsiveApp responsive = ResponsiveApp(context);
  
  return Table(
    children: [
      TableRow(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: responsive.hp(5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    acta == "REGIONAL" || acta == "DISTRITAL"
                        ? Padding(
                            padding: EdgeInsets.only(
                                right: responsive.dp(2),
                                left: responsive.dp(2)),
                            child: SizedBox(
                              height: responsive.hp(12),
                              width: responsive.wp(12),
                              child: partido.logo != ""
                                  ? Image.memory(
                                      bytes,
                                      scale: 0.1,
                                    )
                                  : SizedBox(
                                      width: responsive.wp(5),
                                    ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(right: 10, left: 5),
                            child: SizedBox(
                              height: responsive.hp(12),
                              width: responsive.wp(12),
                              child: partido.logo != ""
                                  ? Image.memory(
                                      bytes,
                                      scale: 0.1,
                                    )
                                  : SizedBox(
                                      width: responsive.wp(6),
                                    ),
                            ),
                          ),
                    acta == "REGIONAL" || acta == "DISTRITAL"
                        ? SizedBox(
                            width: responsive.wp(28),
                            height: responsive.hp(15),
                            child: Center(
                              child: Text(
                                partido.denominacion.toString(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                    textStyle: style, color: AzulApp),
                              ),
                            ),
                          )
                        : SizedBox(
                            width: responsive.wp(35),
                            height: 50,
                            child: Center(
                              child: Text(
                                partido.denominacion.toString(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                    textStyle: style, color: AzulApp),
                              ),
                            ),
                          ),
                    if (acta == "REGIONAL" || acta == "DISTRITAL")
                      Padding(
                        padding: EdgeInsets.only(
                            left: responsive.dp(2.5),
                            right: responsive.dp(5), bottom: 10
                            ),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints.tight(const Size(30, 30)),
                            child: SizedBox(
                              width: 45,
                              height: 45,
                              child: TextFormField(
                                inputFormatters: formatters,
                                decoration: InputDecoration(
                                  counterText: '',
                                  counterStyle: TextStyle(fontSize: 0),
                                ),
                                maxLength: 3,
                                controller: controller,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: false),
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return 'Ingresa un valor';
                                  } else if (value
                                      .contains(RegExp(r'^[0-9]{3}$'))) {
                                    //(^[0-9]*$)
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Solo números"),
                                    ));
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.only(left: 45, right: 40),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: ConstrainedBox(
                              constraints:
                                  BoxConstraints.tight(const Size(30, 30)),
                              child: SizedBox(
                                width: 45,
                                height: 70,
                                child: TextFormField(
                                  //focusNode: FocusNode(),
                                  //autofocus: true,
                                  inputFormatters: formatters,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    counterStyle: TextStyle(fontSize: 0),
                                  ),
                                  maxLength: 3,
                                  controller: controller,
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: false),
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return 'Ingresa un valor';
                                    } else if (value
                                        .contains(RegExp(r'(^[0-9]*$))'))) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("Solo números"),
                                      ));
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (acta == "REGIONAL" || acta == "DISTRITAL")
                      FittedBox(
                        fit: BoxFit.cover,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25, right: 15, bottom: 10),
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints.tight(const Size(30, 30)),
                            child: SizedBox(
                              width: 45,
                              height: 70,
                              child: TextFormField(
                                //focusNode: FocusNode(),
                                //autofocus: true,
                                inputFormatters: formatters,
                                decoration: InputDecoration(
                                  counterText: '',
                                  counterStyle: TextStyle(fontSize: 0),
                                ),
                                maxLength: 3,
                                controller: controllerConsejero,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: false),
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return 'Ingresa un valor';
                                  } else if (value
                                      .contains(RegExp(r'(^[0-9]{3}$)'))) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Solo números"),
                                    ));
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      Container(),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}
