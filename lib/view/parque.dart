// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unused_label

import 'package:flutter/material.dart';
import 'package:flutter_project1/models/parque_model.dart';
import 'package:flutter_project1/view/parque_detail.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Parque extends StatelessWidget {
  Parque({Key? key}) : super(key: key);

  filter() {
    return SimpleDialog(
      title: Text('Parques Proximos'),
      children: [
        Obx(
          () => Slider(
            value: ParquesModel.to.radius.value,
            min: 0,
            max: 10,
            divisions: 10000,
            label: ParquesModel.to.lenght,
            onChanged: (value) => ParquesModel.to.radius.value = value,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 20, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => ParquesModel.to.parquesfilter(),
                child: Text('Filtrar'),
              ),
              TextButton(onPressed: () => Get.back(), child: Text('Cancelar')),
            ],
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ParquesModel());

    return Scaffold(
        appBar: AppBar(
          title: Text("Parques de Estacionamento"),
          actions: [
            IconButton(
              icon: Icon(Icons.radar_rounded),
              onPressed: () {
                showDialog(context: context, builder: (context) => filter());
              },
            ),
          ],
        ),
        body: GetBuilder<ParquesModel>(
          init: controller,
          builder: (value) => GoogleMap(
            mapType: MapType.normal,
            zoomControlsEnabled: true,
            initialCameraPosition:
                CameraPosition(target: controller.positionmap, zoom: 14),
            onMapCreated: controller.onMapCreated,
            myLocationEnabled: true,
            markers: controller.markers,
          ),
        ),
        );

  }
}
