
class Pez {
  int id;
  String nombre;
  String nombreCientifico;
  int talla;
  DateTime fini;
  DateTime ffin;
  String notas;
  String? imageurl;

  Pez({
    required this.id,
    required this.nombre,
    required this.nombreCientifico,
    required this.talla,
    required this.fini,
    required this.ffin,
    required this.notas,
    required this.imageurl,
  });

  factory Pez.fromJson(Map<String, dynamic> json) {
    return Pez(
      id: json['id'] as int,
      nombre: json['nombre'],
      nombreCientifico: json['nombrecientifico'],
      talla: json['talla'] as int,
      fini: DateTime.parse(json['fini']) ,
      ffin: DateTime.parse(json['ffin']?? "9999-01-01"),
      notas: json['notas'] ?? '',
      imageurl: json['imageurl'],
    );
  }

  @override
  String toString() {
    return "Pez{id: $id, nombre: $nombre, nombreCientifico: $nombreCientifico, talla: $talla, fini: $fini, ffin: $ffin, notas: $notas, imageurl: $imageurl}";
  }
}
