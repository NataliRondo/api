// ignore_for_file: use_build_context_synchronously, unnecessary_this, dead_code, unused_import, avoid_print, unnecessary_null_comparison, unrelated_type_equality_checks, non_constant_identifier_names

import 'package:api/api/servicio_login.dart';
import 'package:api/utils/responsive.dart';
import 'package:api/utils/variables.dart';
import 'package:api/widgets/colores.dart';
import 'package:api/widgets/text_decoration.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

bool obscureText = true;

@override
void initState() {
  obscureText = false;
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _usernameController = TextEditingController();
  final _passController = TextEditingController();

  String _email = '', _password = '';

  @override
  Widget build(BuildContext context) {
    final ResponsiveApp responsive = ResponsiveApp.of(context);
    bool isAviable = true;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Container(
                  width: 7,
                  height: 25,
                  color: RojoApp,
                  //padding: EdgeInsets.only(left: 1),
                  alignment: Alignment.topLeft,
                ),
                const SizedBox(width: 5),
                Text(
                  'Iniciar sesión',
                  style: GoogleFonts.lato(
                    fontSize: responsive.dp(responsive.isTablet ? 5 : 7),
                    fontWeight: FontWeight.bold,
                    color: AzulApp,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 30,
            ),
            child: TextoInput(
              controller: _usernameController,
              onChanged: (user) {
                print("email: $user");
                _email = user;
              },
              validator: (user) {
                if (!user!.contains(RegExp(r'(^[0-9]*$)'))) {
                  //RegExp(r'([0-9])$'---> r'([0-9])$')
                  return "Usuario invalido";
                }
                return null;
              },
              label: 'Usuario',
              icono: Icons.person,
            ),
          ),
          SizedBox(
            height: responsive.hp(6),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 30,
            ),
            child: TextoInput(
              controller: _passController,
              onChanged: (pass) {
                print("password: $pass");
                _password = pass;
              },
              validator: (pass) {
                if (pass!.trim().isEmpty) {
                  return 'Contraseña invalida';
                }
                return null;
              },
              obscureText: obscureText,
              label: 'Contraseña',
              icono: Icons.security,
              iconButton: IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
          ),
          SizedBox(
            height: responsive.hp(8),
          ),
          //TextButton
          InkWell(
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  });
              final Direccionip = await Ipify.ipv4();
              await ServicioLogin()
                  .login(_password, _email, Direccionip, context);

              print(Direccionip);
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: BoxDecoration(
                color: isAviable ? RojoApp : AzulApp,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Iniciar',
                      style: GoogleFonts.lato(
                        fontSize: responsive.dp(responsive.isTablet ? 3 : 4.5),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
