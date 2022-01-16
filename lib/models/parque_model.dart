// ignore_for_file: unnecessary_null_comparison, unused_field, prefer_const_constructors, prefer_final_fields, prefer_collection_literals, avoid_function_literals_in_foreach_calls, unused_label

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project1/db/database.dart';
import 'package:flutter_project1/view/parque_detail.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParquesModel extends GetxController {
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final radius = 0.0.obs;

  late StreamSubscription<Position> positionStream;
  LatLng _position = LatLng(41.1466, -8.6176);
  late GoogleMapController _mapsController;
  final markers = Set<Marker>();

  static ParquesModel get to => Get.find<ParquesModel>();
  get mapsController => _mapsController;
  get positionmap => _position;
  String get lenght => radius.value < 1
      ? '${(radius.value * 1000).toStringAsFixed(0)} m'
      : '${(radius.value).toStringAsFixed(1)} km';

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  parquesfilter() {
    final geo = Geoflutterfire();
    final parquesdb = Parquesdb.get();

    GeoFirePoint center =
        geo.point(latitude: latitude.value, longitude: longitude.value);

    CollectionReference ref = parquesdb.collection("parquesEstacionamentos");

    String field = "geohash";

    Stream<List<DocumentSnapshot>> stream = geo
        .collection(collectionRef: ref)
        .within(center: center, radius: radius.value, field: field);

    stream.listen((List<DocumentSnapshot> parquesEstacionamentos) {
      markers.clear();
      parquesEstacionamentos.forEach((parquesEstacionamento) {
        addMarker(parquesEstacionamento);
        update();
      });
      Get.back();
    });
  }

  onMapCreated(GoogleMapController gmc) async {
    _mapsController = gmc;
    getPosition();
    loadParques();

    var style =
        await rootBundle.loadString("assets/map/configuration_map.json");
    _mapsController.setMapStyle(style);
  }

  loadParques() async {
    FirebaseFirestore parquesdb = Parquesdb.get();
    final parquesEstacionamentos =
        await parquesdb.collection("parquesEstacionamentos").get();

    parquesEstacionamentos.docs
        .forEach((parquesEstacionamento) => addMarker(parquesEstacionamento));
  }

  addMarker(parquesEstacionamento) async {
    GeoPoint point = parquesEstacionamento.get("position.geopoint");
    final Uint8List icon =
        await getBytesFromAsset('assets/icon_parque.png', 64);
    markers.add(
      Marker(
        markerId: MarkerId(parquesEstacionamento.id),
        position: LatLng(point.latitude, point.longitude),
        infoWindow: InfoWindow(title: parquesEstacionamento.get("name")),
        icon: BitmapDescriptor.fromBytes(icon),
        onTap: () => showDetails(parquesEstacionamento.data()),
      ),
    );
    update();
  }

  showDetails(parquesEstacionamento) {
    Get.bottomSheet(
      ParqueDetails(
          name: parquesEstacionamento["name"],
          image: parquesEstacionamento["image"]),
      barrierColor: Colors.transparent,
    );
  }

  watchPosition() async {
    positionStream = Geolocator.getPositionStream().listen((Position position) {
      if (position != null) {
        latitude.value = position.latitude;
        longitude.value = position.longitude;
      }
    });
  }

  @override
  void onClose() {
    positionStream.cancel();
    super.onClose();
  }

  Future<Position> _currentLocation() async {
    LocationPermission permission;
    bool activated = await Geolocator.isLocationServiceEnabled();

    if (!activated) {
      return Future.error("Ligue a Localização");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Permita o Acesso a Localização");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Permita o Acesso a Localização nas Definições");
    }

    return await Geolocator.getCurrentPosition();
  }

  getPosition() async {
    try {
      final positionPosition = await _currentLocation();
      latitude.value = positionPosition.latitude;
      longitude.value = positionPosition.longitude;
      _mapsController.animateCamera(
          CameraUpdate.newLatLng(LatLng(latitude.value, longitude.value)));
    } catch (e) {
      Get.snackbar(
        "Erro",
        e.toString(),
        backgroundColor: Colors.green[900],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

}
