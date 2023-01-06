import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const uri = "http://190.119.219.155/wstxqgvyqyunafsvcy";
const metodoPost = "/api/login/authenticate";
const metodoGet = "/api/personero/MisMesas";

var style = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
var formatters = [
  FilteringTextInputFormatter.deny('.'),
  FilteringTextInputFormatter.deny(','),
  FilteringTextInputFormatter.deny(RegExp(r'[a-zA-Z]')),
  FilteringTextInputFormatter.deny('/'),
  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
];
