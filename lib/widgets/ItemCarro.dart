// ignore_for_file: file_names, prefer_const_constructors, unnecessary_this, deprecated_member_use, must_be_immutable, use_key_in_widget_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables, unused_element, unused_import

/*

import 'package:flutter/material.dart';

class ItemCarro {
  String brand;
  String model;
  String plate;

  ItemCarro(
      {required this.brand, required this.model, required this.plate});}

class ListaCarros extends StatelessWidget {
  //const ListaCarros({ Key? key }) : super(key: key);
  void ItemAnuncio({
    @required this.anuncio,
    this.onTapItem,
    this.onPressedRemover
  });

  

    @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTapItem,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(children: <Widget>[

            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  Text(
                      carro!.brand,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text("R\$ ${carro!.model} "),
                ],),
              ),
            ),
            if( this.onPressedRemover != null ) Expanded(
              flex: 1,
              child: FlatButton(
                color: Colors.red,
                padding: EdgeInsets.all(10),
                onPressed: this.onPressedRemover,
                child: Icon(Icons.delete, color: Colors.white,),
              ),
            )
            //botao remover

          ],),
        ),
      ),
    );
  }
}*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/models/carros_model.dart';
import 'package:flutter_project1/view/carros.dart';
import 'package:flutter_project1/view/carrosfake.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ItemCarro extends StatelessWidget {
  //final _auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  User? user = FirebaseAuth.instance.currentUser;
  //const ItemCarro({CarModel? carmodel});
  CarModel carModel = CarModel();



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
          child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 120,
                    height: 120,
                    // Tentar passar cor do carro
                    child: Container(
                        color: Colors.white,
                        child: Icon(
                          Icons.directions_car_rounded,
                          color: Colors.grey[600],
                          size: 120,
                        )),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Passar Marca e Modelo
                          Text("Fiat",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("Panda"),
                        ],
                      ),
                    ),
                  ),
                  //if(onPressedRemover != null)
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      color: Colors.red,
                      padding: EdgeInsets.all(10),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  title: Text("Confirmar"),
                                  content: Text("Deseja excluir o seu carro?"),
                                  actions: <Widget>[
                                    FlatButton(
                                        child: Text(
                                          "Cancelar",
                                          style: TextStyle(color: Colors.teal),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        }),
                                    FlatButton(
                                        color: Colors.red,
                                        child: Text(
                                          "Remover",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          _removerCarro();
                                          Navigator.of(context).pop();
                                          Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CarrosFake()));
                                          Fluttertoast.showToast(msg: "Carro Adicionado Com Sucesso!");
                                        }),
                                  ]);
                            });
                      },
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  )
                ],
              ))),
    );
  }

  _removerCarro() async {
   
      
      //User? user = _auth.currentUser;
      //CarModel carModel = CarModel();
    // writing all the values

 
    /*carModel.brand = carModel.brand;
    carModel.model = carModel.model;
    carModel.plate = carModel.plate;
    carModel.color = carModel.color;
    carModel.fuel = carModel.fuel;*/

    db
        .collection("cars")
        .doc(user!.uid)
        .collection("my_cars")
        .doc("1")
        .delete();
  }
}
