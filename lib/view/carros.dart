// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_element, non_constant_identifier_names, unused_local_variable, avoid_unnecessary_containers, avoid_print, prefer_typing_uninitialized_variables, unrelated_type_equality_checks, curly_braces_in_flow_control_structures, unused_import

/*
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/models/carros_model.dart';
import 'package:flutter_project1/view/novocarro.dart';
import 'package:flutter_project1/widgets/ItemCarro.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Carros extends StatelessWidget {

final _controller = StreamController<QuerySnapshot>.broadcast();




CarModel carModel = CarModel();




    FirebaseAuth auth = FirebaseAuth.instance;
    User? user =  FirebaseAuth.instance.currentUser; //FirebaseUser usuarioLogado = await auth.currentUser();
  

  Future<Stream<QuerySnapshot>> get _listenerCarros async {

    //await _recuperaDadosUsuarioLogado();

    FirebaseFirestore db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = 


        db
        .collection("cars")
        .doc(user!.uid)
        .collection("my_cars")
        .snapshots();

    stream.listen((dados){
      _controller.add( dados );
    });
    return stream;
  }


 


  @override
  Widget build(BuildContext context) =>
  
 /* var carregarDados = Center(
      child: Column(children: <Widget>[
        Text("Carregando anúncios"),
        CircularProgressIndicator()
      ],),
    );*/
  
  Scaffold(
        appBar: AppBar(
          title: Text("Carros"),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: /*(){
            checkIfLikedOrNot(context);
          },*/
          () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => NovoCarro()));
          },
        ),
        body: ListView.builder(
          itemCount:1,
          itemBuilder: (_, indice){
            return ItemCarro();
          }),);*/

/*
          body: StreamBuilder(
        stream: _controller.stream,
        builder: (context, snapshot){
          
          switch( snapshot.connectionState ){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return carregarDados;
              break;
            case ConnectionState.active:
            case ConnectionState.done:
          
              //Exibe mensagem de erro
              if(snapshot.hasError)
                return Text("Erro ao carregar os dados!");
              
              QuerySnapshot querySnapshot = snapshot.data;

              return ListView.builder(
                  itemCount: querySnapshot.docs.length,
                  itemBuilder: (_, indice){
                    
                    List<DocumentSnapshot> carros = querySnapshot.docs.toList();
                    DocumentSnapshot documentSnapshot = carros[indice];
                    CarModel anuncio = CarModel.fromMap(DocumentSnapshot);
                    
                    return ItemCarro();
                      },
                    );
                  }
              
              
          }
          
         
          
      
      ),
      );return Container();}

*/

/*
checkIfLikedOrNot(context) async{
  User? user = _auth.currentUser;
   DocumentSnapshot ds = await FirebaseFirestore.instance.collection("cars").doc(user!.uid).collection("my_cars").doc().get();
if(ds.exists){
  Fluttertoast.showToast(msg: "Já tem um carro adicionado!");
}else{
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => NovoCarro()));
}
}*/

/*
_isCollectionExits(context) async {
    final snapshot =
        await FirebaseFirestore.instance.collection("my_cars").get();
    if (snapshot.docs.isEmpty) {
      Fluttertoast.showToast(msg: "Já tem um carro adicionado!");
      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => NovoCarro()));
    }else {
      //Fluttertoast.showToast(msg: "Já tem um carro adicionado!");
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => NovoCarro()));
    }
  }*/

/*_removerAnuncio(String idAnuncio){

    Firestore db = Firestore.instance;
    db.collection("meus_anuncios")
      .document( _idUsuarioLogado )
      .collection("anuncios")
      .document( idAnuncio )
      .delete();

  }*/

//}

// Ver botao voltar atras

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/models/carros_model.dart';
import 'package:flutter_project1/view/menu.dart';
import 'package:flutter_project1/view/novocarro.dart';
import 'package:flutter_project1/widgets/ItemCarro.dart';

class Carros extends StatefulWidget {
  const Carros({Key? key}) : super(key: key);

  @override
  _CarrosState createState() => _CarrosState();
}

class _CarrosState extends State<Carros> {
  Future? _data;


  Future getCars() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    QuerySnapshot qn = await db
        .collection("cars")
        .doc(user!.uid)
        .collection("my_cars")
        .get();
    return qn.docs;
  }

  /// Check If Document Exists
  Future<int> docExiste() async {
    // Get reference to Firestore collection
    var collectionRef = FirebaseFirestore.instance.collection("my_cars");
    var doc = await collectionRef.doc("1").get();
    if (doc.exists == true)
      return 1;
    else
      return 0;
  }

  /*Future getCount() async => FirebaseFirestore.instance
      .collection("my_cars") //your collectionref
      .where('deleted', isEqualTo: false)
      .get()
      .then((value) {
    var count = 0;
    count = value.docs.length;

    return count;
  });*/

  @override
  void initState() {
    super.initState();
    _data = getCars();
  }

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
        body: FutureBuilder(
            future: _data,
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("Loading..."),
                );
              } else {
                return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (_, index) {
                      return ItemCarro();
                    });
              }
            }),
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
