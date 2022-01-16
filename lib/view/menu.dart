// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, unused_import, use_key_in_widget_constructors, prefer_const_declarations

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/main.dart';
import 'package:flutter_project1/view/carros.dart';
import 'package:flutter_project1/view/carros2.dart';
import 'package:flutter_project1/view/login.dart';
import 'package:flutter_project1/view/parque.dart';
import 'package:flutter_project1/view/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project1/models/user_model.dart';
import 'package:flutter_project1/view/qrcode.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

final _auth = FirebaseAuth.instance;

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) => Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Menu"),
        backgroundColor: Color(0xff276e68),
      ),
      // Criação das grelhas
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20), // Espaço Bordas
        crossAxisSpacing: 10, // Espaço Coluna
        mainAxisSpacing: 10, // Espaço Linha
        crossAxisCount: 2, // Número de divisorias por linha
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey[600],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10),
                buildMenuWidget(
                  icon: Icons.directions_car_rounded,
                  text: "Meus Carros",
                  onClicked: () => selectedWidget(context, 0),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey[600],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10),
                buildMenuWidget(
                  icon: Icons.qr_code_2,
                  text: "Cheguei Agora",
                  onClicked: () => selectedWidget(context, 1),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey[600],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10),
                buildMenuWidget(
                  icon: Icons.map,
                  text: "Maps",
                  onClicked: () => selectedWidget(context, 2),
                ),
              ],
            ),
          ),
        ],
      ));
}

Widget buildMenuWidget({
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  final color = Colors.white;
  final hoverColor = Colors.teal[800];

  return ListTile(
    leading: Icon(icon, color: color, size: 45),
    title: Text(text,
        style:
            TextStyle(color: color, fontSize: 16.7, fontWeight: FontWeight.bold)),
    hoverColor: hoverColor,
    onTap: onClicked,
  );
}

void selectedWidget(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CarrosFake()));
      break;
    case 1:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => QRCode()));
      break;
    case 2:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Parque()));
      break;
    default:
  }
}

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  final email = "maria@gmail.com";
  final name = "Maria Josefina";
  final image = "https://i.imgur.com/E9JKkIP.png";
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color(0xff276e68),
        child: ListView(
          children: <Widget>[
            buildHeader(
              name: name,
              email: email,
              image: image,
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: "Profile",
                    icon: Icons.people,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: "Favourites",
                    icon: Icons.favorite_border,
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: "Updates",
                    icon: Icons.update,
                  ),
                  const SizedBox(height: 24),
                  Divider(thickness: 2, color: Colors.white70),
                  const SizedBox(height: 24),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: "Favourites",
                    icon: Icons.favorite_border,
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: "Logout",
                    icon: Icons.logout,
                    onClicked: () => logout(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String image,
    required String name,
    required String email,
  }) =>
      InkWell(
        child: Container(
            padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
            child: Row(
              children: [
                CircleAvatar(radius: 30, backgroundImage: NetworkImage(image)),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ],
            )),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.red;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}

// Função Logout
Future<void> logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
}

void selectedItem(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Profile()));
      break;
    default:
  }
}
