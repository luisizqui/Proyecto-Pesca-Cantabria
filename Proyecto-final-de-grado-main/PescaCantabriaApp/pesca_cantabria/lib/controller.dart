import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pesca_cantabria/models/pez.dart';
import 'package:pesca_cantabria/models/zona.dart';
import 'package:pesca_cantabria/models/peces_zona.dart';

class Controller {
  // Cambiar esta ip cuando se cambie la ip del servidor API, localhost sirve para las pruebas de la version web
  static const String apiUrl = 'http://192.168.1.111:8080/api';
  //static const String apiUrl = 'http://localhost:8080/api';

  static Future<List<Pez>> fetchPeces() async {
    final response = await http.get(Uri.parse('$apiUrl/peces'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Pez.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load peces');
    }
  }

  static Future<Peceszona> fetchPecesId(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/peces/$id'));
    if (response.statusCode == 200) {
      return Peceszona.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Peceszona with id $id');
    }
  }

  static Future<List<Zona>> fetchZonas() async {
    final response = await http.get(Uri.parse('$apiUrl/zonas'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Zona.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load zonas');
    }
  }

  static Future<Peceszona> fetchZonaId(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/zonas/$id'));
    if (response.statusCode == 200) {
      return Peceszona.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Peceszona with id $id');
    }
  }

  static Future<List<Peceszona>> fetchPecesZonas() async {
    final response = await http.get(Uri.parse('$apiUrl/peces-zona'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Peceszona.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load peces-zona');
    }
  }

  static Future<Peceszona> fetchPecesZonaId(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/peces-zona/$id'));
    if (response.statusCode == 200) {
      return Peceszona.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Peceszona with id $id');
    }
  }

    static Future<List<Peceszona>> fetchPecesZonaZonaId(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/peces-zona/zona/$id'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Peceszona.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load peces-zona');
    }
  }

    static Future<List<Peceszona>> fetchPecesZonaPezId(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/peces-zona/pez/$id'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Peceszona.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load peces-zona');
    }
  }

  // Queria usar directamente la direccion de la imagen en la base de datos pero como no tengo ip estatica no puedo
  static String getImageUrl(String imageName) {
    return '$apiUrl/foto/$imageName';
  }
}
