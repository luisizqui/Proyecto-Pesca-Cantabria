import 'package:pesca_cantabria/models/pez.dart';
import 'package:pesca_cantabria/models/zona.dart';

class Peceszona {
  int id;
  Pez pez;
  Zona zona;

  Peceszona({required this.id, required this.pez, required this.zona});

  factory Peceszona.fromJson(Map<String, dynamic> json) {
    return Peceszona(
      id: json['id'] as int,
      pez: Pez.fromJson(json['pezZona']),      // <-- changed key
      zona: Zona.fromJson(json['zonaPez']),   // <-- changed key
    );
  }

  @override
  String toString() {
    return "Peceszona{id: $id, pez: $pez, zona: $zona}";
  }
}
