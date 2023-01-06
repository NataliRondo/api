// ignore_for_file: unnecessary_this

import 'package:api/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TextoInput extends StatelessWidget {
  final String? label;
  final IconData? icono;
  final IconData? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final void Function(String text)? onChanged;
  final String? Function(String? text)? validator;
  IconButton? iconButton;

  TextoInput(
      {Key? key,
      this.suffixIcon,
      this.controller,
      this.label,
      this.icono,
      this.obscureText = false,
      this.onChanged,
      this.validator,
      this.iconButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ResponsiveApp responsive = ResponsiveApp.of(context);
    return TextFormField(
      key: key,
      controller: controller,
      validator: this.validator,
      obscureText: this.obscureText,
      onChanged: this.onChanged,
      style: GoogleFonts.lato(),
      autofocus: this.obscureText,
      decoration: InputDecoration(
        labelText: this.label,
        //hintText: this.label,
        prefixIcon: Icon(this.icono),
        suffixIcon: iconButton,
        contentPadding: const EdgeInsets.all(10),
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: responsive.dp(5),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
      ),
    );
  }
}
