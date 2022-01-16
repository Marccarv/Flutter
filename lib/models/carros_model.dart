class CarModel {
  String? uid;
  String? brand;
  String? model;
  String? plate;
  String? color;
  String? fuel;

  CarModel(
      {this.uid, this.brand, this.model, this.plate, this.color, this.fuel});
  // Receber Dados do Servidor
  factory CarModel.fromMap(map) {
    return CarModel(
      uid: map['uid'],
      brand: map['brand'],
      model: map['model'],
      plate: map['plate'],
      color: map['color'],
      fuel: map['fuel'],
    );
  }

  // Enviar Dados Para o Servidor
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'brand': brand,
      'model': model,
      'plate': plate,
      'color': color,
      'fuel': fuel,
    };
  }
}
