

import 'package:api/view/vistas/distritosView.dart';
import 'package:api/view/login/login.dart';
import 'package:api/view/vistas/mesa_elegir.dart';
import 'package:api/view/vistas/mesas.dart';

final routes = {
  '/login' : (context) => const LoginPage(),
  '/distritos': (context) => DistritosView(),
  //'/local': (context) => const LocalesView(),
  '/mesas': (context) => Mesas(),
  '/escoger-Acta':(context) => MesaElegir(),
  
};