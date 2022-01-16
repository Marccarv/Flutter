// ignore_for_file: prefer_const_constructors, unused_field, prefer_const_literals_to_create_immutables, deprecated_member_use, prefer_final_fields, prefer_collection_literals



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_project1/models/carros_model.dart';
import 'package:flutter_project1/view/carros.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NovoCarro extends StatefulWidget {
  const NovoCarro({Key? key}) : super(key: key);

  @override
  _NovoCarroState createState() => _NovoCarroState();
}

class _NovoCarroState extends State<NovoCarro> {
  // string for displaying the error Message
  String? errorMessage;

  //CarModel? _novocarro;
  final _auth = FirebaseAuth.instance;
  // our form key
  final formGlobalKey = GlobalKey<FormState>();
  // Controllers
  final brandController = TextEditingController();
  final modelController = TextEditingController();
  final plateController = TextEditingController();
  final colorController = TextEditingController();
  final fuelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Brand Field
    final brandField = TextFormField(
        autofocus: false,
        controller: brandController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = RegExp('^[a-zA-Z]');
          if (value!.isEmpty) {
            return ("Preenchimento Obrigatória");
          }
          if (!regex.hasMatch(value)) {
            return ("Insira Uma Marca Válida");
          }
          return null;
        },
        onSaved: (value) {
          brandController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.directions_car_rounded),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Marca",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //Model Field
    final modelField = TextFormField(
        autofocus: false,
        controller: modelController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = RegExp('^[a-zA-Z0-9]');
          if (value!.isEmpty) {
            return ("Preenchimento Obrigatória");
          }
          if (!regex.hasMatch(value)) {
            return ("Insira Um Modelo Válido");
          }
          return null;
        },
        onSaved: (value) {
          modelController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.directions_car_rounded),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Modelo",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //Plate Field
    final plateField = TextFormField(
        autofocus: false,
        controller: plateController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = RegExp("^[A-Z0-9]{2}-[A-Z0-9]{2}-[A-Z0-9]{2}");
          if (value!.isEmpty) {
            return ("Preenchimento Obrigatória");
          }
          if (!regex.hasMatch(value)) {
            return ("Insira Uma Matrícula Válida");
          }
          return null;
        },
        onSaved: (value) {
          plateController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.directions_car_rounded),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Matrícula",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //Color Field
    final colorField = TextFormField(
        autofocus: false,
        controller: colorController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = RegExp('^[a-zA-Z]');
          if (value!.isEmpty) {
            return ("Preenchimento Obrigatória");
          }
          if (!regex.hasMatch(value)) {
            return ("Insira Uma Cor Válida");
          }
          return null;
        },
        onSaved: (value) {
          colorController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.directions_car_rounded),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Cor",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //Fuel Field
    final fuelField = TextFormField(
        autofocus: false,
        controller: fuelController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = RegExp('^[a-zA-Z]');
          if (value!.isEmpty) {
            return ("Preenchimento Obrigatória");
          }
          if (!regex.hasMatch(value)) {
            return ("Insira Um Combustível Válido");
          }
          return null;
        },
        onSaved: (value) {
          fuelController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.directions_car_rounded),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Combustível",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //Botão Adicionar Carro
    final criarBotao = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.teal.shade800,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            //postDetailsToFirestore();

            /*
            if (_formKey.currentState!.validate()) {
              (value) => postDetailsToFirestore();
            }else{
              print("Erro");
            }*/

            /*addCar(
                brandController.text,
                modelController.text,
                plateController.text,
                colorController.text,
                fuelController.text);*/

            if (formGlobalKey.currentState!.validate()) {
              formGlobalKey.currentState!.save();
              postDetailsToFirestore();
              // use the email provided here
            }
          },
          child: Text(
            "Registar Carro",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.teal.shade800),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: formGlobalKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        child: Icon(Icons.directions_car_rounded,
                            size: 140, color: Colors.grey[600])),
                    SizedBox(height: 45),
                    brandField,
                    SizedBox(height: 20),
                    modelField,
                    SizedBox(height: 20),
                    plateField,
                    SizedBox(height: 20),
                    colorField,
                    SizedBox(height: 20),
                    fuelField,
                    SizedBox(height: 20),
                    criarBotao,
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // post details anuncios Firestore
  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;


    CarModel carModel = CarModel();
    // writing all the values

    carModel.uid = user!.uid;
    carModel.brand = brandController.text;
    carModel.model = modelController.text;
    carModel.plate = plateController.text;
    carModel.color = colorController.text;
    carModel.fuel = fuelController.text;

    await firebaseFirestore
        .collection("cars")
        .doc(user.uid)
        .collection("my_cars")
        .doc("1")
        .set(carModel.toMap());

    //.collection("meus_carros").doc(user.uid).collection("carros").doc(_anuncio.id).set(carModel.toMap())
    /*.collection("users")
        .doc(user.uid)
        .set(userModel.toMap());*/
    Fluttertoast.showToast(msg: "Carro Adicionado Com Sucesso!");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => Carros()), (route) => false);
  }

  /*if (_formKey.currentState!.validate()) {
      try (value) => postDetailsToFirestore();
    } else {
      print("Ocorreu um Erro Inesperado");
    }
    }*/

  //Adicionar Carro
  void addCar(String brand, String model, String plate, String color,
      String fuel) async {
    if (formGlobalKey.currentState!.validate()) {
      try {
        (value) => postDetailsToFirestore();
      } catch (e) {
        throw Exception("Ocorreu um Erro Inesperado");
      }
    }
  }
}
