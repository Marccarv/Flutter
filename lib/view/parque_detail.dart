// ignore_for_file: prefer_const_constructors, unused_label, prefer_const_literals_to_create_immutables, unused_element, deprecated_member_use, unnecessary_new
import 'package:flutter/material.dart';


class ParqueDetails extends StatelessWidget {
  final String name;
  final String image;

  const ParqueDetails({Key? key, required this.name, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Image.network(
              image,
              height: 250,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            IconButton(
              icon: Icon(Icons.add_circle_outline_rounded),
              color: Color(0xff276e68),
              iconSize: 80,
              padding: EdgeInsets.only(top: 160, left: 300),
              onPressed: () {},
            ),
            Container(
                margin: EdgeInsets.all(24),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black.withOpacity(0.9),
                ),
                child: Text(
                  name,
                  style: TextStyle(
                    color: Color(0xff276e68),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ],
        ));
  }
}
