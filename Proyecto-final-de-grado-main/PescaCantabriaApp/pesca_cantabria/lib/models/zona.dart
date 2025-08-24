class Zona {
  int id;
  String nombre;
  String tipo;
  double latitud;
  double longitud;
  String? imageurl;

  Zona({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.latitud,
    required this.longitud,
    required this.imageurl,
  });

  factory Zona.fromJson(Map<String, dynamic> json) {
    return Zona(
      id: json['id'] as int,
      nombre: json['nombre'],
      tipo: json['tipo'],
      latitud: json['latitud'] as double,
      longitud: json['longitud'] as double,
      imageurl: json['imageurl'],
    );
  }

  @override
  String toString() {
    return "Zona{id: $id, nombre: $nombre, tipo: $tipo, coordenadas: $latitud $longitud, imageurl: $imageurl}";
  }
}
