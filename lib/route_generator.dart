/*// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/view/login.dart';
import 'package:flutter_project1/view/menu.dart';
import 'package:flutter_project1/view/register.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Login());
      case "/menu":
        return MaterialPageRoute(builder: (_) => Menu());
      case "/register":
        return MaterialPageRoute(builder: (_) => Register());
      default:
        return _erroRota();
    }
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Página não encontrada'),
          ),
          body: Center(
            child: Text('Página não encontrada'),
          ));
    });
  }
}*/
