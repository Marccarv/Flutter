// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Profile"),
      centerTitle: true,
      backgroundColor: Colors.red,
    )
  );
}




/*
 import 'package:cloud_firestore/cloud_firestore.dart';
    import 'package:flutter/material.dart';

    class LoadDataFromFirestore extends StatefulWidget {
      @override
      _LoadDataFromFirestoreState createState() => _LoadDataFromFirestoreState();
    }

    class _LoadDataFromFirestoreState extends State<LoadDataFromFirestore> {
      @override
      void initState() {
        super.initState();
        getDriversList().then((results) {
          setState(() {
            querySnapshot = results;
          });
        });
      }

      late QuerySnapshot querySnapshot;
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: _showDrivers(),
        );
      }

    //build widget as prefered
    //i'll be using a listview.builder
      Widget _showDrivers() {
        //check if querysnapshot is null
        if (querySnapshot != null) {
          return ListView.builder(
            primary: false,
            itemCount: querySnapshot.docs.length,
            padding: EdgeInsets.all(12),
            itemBuilder: (context, i) {
              return Column(
                children: <Widget>[
//load data into widgets
                  Text("${querySnapshot.docs[i].data()}"),
                ],
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }

      //get firestore instance
      getDriversList() async {
        return await FirebaseFirestore.instance.collection('users').get();   
      }
    }*/