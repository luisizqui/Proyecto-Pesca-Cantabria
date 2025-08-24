import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pesca_cantabria/controller.dart';
import 'package:pesca_cantabria/models/zona.dart';
import 'package:pesca_cantabria/screens/zona_detalles_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late Future<List<Zona>> _zonasFuture;

  @override
  void initState() {
    super.initState();
    _zonasFuture = Controller.fetchZonas();
  }

  @override
  Widget build(BuildContext context) {
    //coodenadas del centro del mapa
    double defaultLat = 43.27714848221713;
    double defaultLng = -4.05375530401992;
    String selectedZone = '';

    return Scaffold(
      body: FutureBuilder<List<Zona>>(
        future: _zonasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final zonas = snapshot.data!;
            final Set<Marker> markers =
                zonas.map((zona) {
                  return Marker(
                    markerId: MarkerId(zona.id.toString()),
                    position: LatLng(zona.latitud, zona.longitud),
                    infoWindow: InfoWindow(title: zona.nombre),
                    onTap: () {
                      if (selectedZone != zona.nombre) {
                        selectedZone = zona.nombre;
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ZonaDetallesScreen(zona: zona),
                          ),
                        );
                      }
                    },
                  );
                }).toSet();

            // centra el mapa en las coordenadas de arriba
            final initialPosition = CameraPosition(
              target: LatLng(defaultLat, defaultLng),
              zoom: 8.2,
            );

            return GoogleMap(
              initialCameraPosition: initialPosition,
              markers: markers,
            );
          }
        },
      ),
    );
  }
}
