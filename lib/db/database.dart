import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class Parquesdb {
  Parquesdb._();
  static final Parquesdb _instance = Parquesdb._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static get() {
    return Parquesdb._instance._firestore;
  }

  static setupDemoData() async {
    FirebaseFirestore firestore = Parquesdb.get();
    final geo = Geoflutterfire();

    List<GeoFirePoint> parquesEstacionamentos = [
      geo.point(latitude: 41.148137679913965, longitude: -8.609170450516665),
      geo.point(latitude: 41.148137679913965, longitude: -8.60360062779814),
      geo.point(latitude: 41.15103157023627,  longitude: -8.609616036334145),
      geo.point(latitude: 41.141930064068845, longitude: -8.614907367916741),
      geo.point(latitude: 41.1413079398742,  longitude: -8.618190425514936),
    ];
    final dados = [
      {
        'name': 'Parque de Estacionamento D.João I',
        'image': 'https://www.empark.com/media/cache/media/uploads/parkings/PRACA%20DO%20ALMADA_POVOA%20DE%20VARZIM_1448648953.jpg',
        'position': parquesEstacionamentos[0].data,
      },
      {
        'nome': 'Parque de Estacionamento Central',
        'image':
            'https://media.parkimeter.com/images/parkings/medium/1304-7db328260beab6a569d021f2294fd1b4.jpg',
        'position': parquesEstacionamentos[1].data,
      },
      {
        'nome': 'Parque de Estacionamento da Trindade',
        'image':
            'https://mobilidade.cm-porto.pt/files/uploads/cms/mobilidade/15/files/38/fib-parque-estacionamento-trindade-01.jpg',
        'position': parquesEstacionamentos[2].data,
      },
      {
        'nome': 'Parque de Estacionamento Saba Ribeiro',
        'image':
            'https://media.parkimeter.com/images/parkings/medium/1157-19ac7ebbc8f44f957be26455b47392b6.jpg',
        'position': parquesEstacionamentos[3].data,
      },
        {
        'nome': 'Parque de Estacionamento da Alfândega',
        'image':
            'https://imagens.publico.pt/imagens.aspx/1328593?tp=UH&db=IMAGENS&type=JPG',
        'position': parquesEstacionamentos[4].data,
      },
    ];

    await firestore.collection('parquesEstacionamentos').add(dados[0]);
    await firestore.collection('parquesEstacionamentos').add(dados[1]);
    await firestore.collection('parquesEstacionamentos').add(dados[2]);
    await firestore.collection('parquesEstacionamentos').add(dados[3]);
    await firestore.collection('parquesEstacionamentos').add(dados[4]);
  }
}

