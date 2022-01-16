// ignore_for_file: unused_import, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/models/carros_model.dart';
import 'package:flutter_project1/view/menu.dart';
import 'package:flutter_project1/view/novocarro.dart';
import 'package:flutter_project1/widgets/ItemCarro.dart';

class CarrosFake extends StatefulWidget {
  const CarrosFake({Key? key}) : super(key: key);

  @override
  _CarrosFakeState createState() => _CarrosFakeState();
}

class _CarrosFakeState extends State<CarrosFake> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Carros"),
          centerTitle: true,
          backgroundColor: Colors.teal,
          actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Menu'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        ),
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: () {
            //checkIfLikedOrNot(context);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => NovoCarro()));
          },
        ),
      );

      void handleClick(String value) {
    switch (value) {
      case 'Menu':
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Menu()));
        break;
    }
}
}