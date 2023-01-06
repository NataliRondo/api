// ignore_for_file: use_build_context_synchronously

import 'package:api/utils/responsive.dart';
import 'package:api/widgets/colores.dart';
import 'package:api/widgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    //checkLogin();
  }

  void checkLogin() async {
    //SharedPreferences pref = await SharedPreferences.getInstance();
    //List<String>? session = pref.getStringList("usuario");
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveApp responsive = ResponsiveApp.of(context);
    final double tam = responsive.wp(15);

    return Scaffold(
      backgroundColor: FondoApp,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          padding: const EdgeInsets.only(bottom: 5),
          children: [
            SizedBox(
              height: responsive.hp(15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/header-logo.png',
                  width: responsive.wp(55),
                  height: responsive.hp(20),
                ),
              ],
            ),
            SizedBox(
              height: responsive.hp(responsive.isTablet ? 5 : 10),
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: responsive.isTablet ? tam * 0.9 : tam * 0.4,
                  left: responsive.isTablet ? tam * 0.9 : tam * 0.4),
              child: SingleChildScrollView(
                child: Container(
                  width: responsive.wp(4),
                  //height: size.height * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AzulApp,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const LoginForm(),
                ),
              ),
            ),
            Center(
              child: Row(
                children: [
                  SizedBox(
                    width: responsive.wp(responsive.isTablet ? 15 : 12),
                  ),
                  /*
                  Flexible(
                    flex: 1,
                    child: Text(
                      '¿Olvido su contraseña?',
                      style: GoogleFonts.lato(
                        fontSize: responsive.dp(responsive.isTablet ? 2 : 4),
                        fontWeight: FontWeight.bold,
                        color: AzulApp,
                      ),
                    ),
                  ),
                  IconButton(
                    //padding:  EdgeInsets.only(left: tam),
                    onPressed: () {},
                    icon: const Icon(Icons.info),
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
