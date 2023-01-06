import 'package:api/api/servicio_mesa.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Row buscar(TextEditingController buscarMesa, Color color, double left,
    Key keyForm, BuildContext context) {
  ServicioMesa servicioMesa = ServicioMesa();
  return Row(
    children: [
      Form(
        key: keyForm,
        child: Padding(
          padding: EdgeInsets.only(left: left),
          child: SizedBox(
            height: 45,
            width: 150,
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(15),
              child: TextField(
                //autofocus: true,
                controller: buscarMesa,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      InkWell(
        onTap: () async {
          servicioMesa.buscarMesa(buscarMesa.text, context);
          buscarMesa.clear();
          /*Future.delayed(Duration(seconds: 10), () {
            buscarMesa.clear();
          });*/
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Container(
            height: 35,
            width: 100,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                "Buscar",
                style: GoogleFonts.lato(
                  //textStyle: style3,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
