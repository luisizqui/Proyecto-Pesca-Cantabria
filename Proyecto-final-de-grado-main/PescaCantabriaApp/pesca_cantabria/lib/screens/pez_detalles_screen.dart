import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pesca_cantabria/models/pez.dart';
import 'package:pesca_cantabria/models/peces_zona.dart';
import 'package:pesca_cantabria/controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pesca_cantabria/screens/zona_detalles_screen.dart';
import 'package:pesca_cantabria/enums/meses.dart';

class PezDetallesScreen extends StatefulWidget {
  final Pez pez;
  const PezDetallesScreen({super.key, required this.pez});

  @override
  State<PezDetallesScreen> createState() => _PezDetallesScreenState();
}

class _PezDetallesScreenState extends State<PezDetallesScreen> {
  late Future<List<Peceszona>> _zonasFuture;

  @override
  void initState() {
    super.initState();
    // You need to implement this method in your controller
    _zonasFuture = Controller.fetchPecesZonaPezId(widget.pez.id);
  }

  @override
  Widget build(BuildContext context) {
    //coodenadas del centro del mapa
    double defaultLat = 43.27714848221713;
    double defaultLng = -4.05375530401992;
    String selectedZone = '';

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Text(
                widget.pez.nombre,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.pez.nombreCientifico,
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 16),
              CachedNetworkImage(
                imageUrl:
                    widget.pez.imageurl != null
                        ? Controller.getImageUrl(widget.pez.imageurl!)
                        : 'https://plus.unsplash.com/premium_photo-1722908885987-628cef023cc9?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGV6JTIwbmVtb3xlbnwwfHwwfHx8MA%3D%3D',
                placeholder:
                    (context, url) => const CircularProgressIndicator(),
                width: 300,
                height: 150,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Talla mínima: ${widget.pez.talla}cm',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Inicio veda: ${widget.pez.fini.day}/${widget.pez.fini.month}/${widget.pez.fini.year}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        widget.pez.ffin.year != 9999
                            ? 'Fin veda: \n ${widget.pez.ffin.day} de ${meses[widget.pez.ffin.month]}'
                            : 'Fin veda:\n Hasta alcanzar cupo',
                      ),
                      if (widget.pez.notas.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Notas: ${widget.pez.notas}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Zonas donde se encuentra',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 300,
                child: FutureBuilder<List<Peceszona>>(
                  future: _zonasFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final zonas =
                          snapshot.data!.map((pz) => pz.zona).toList();
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
                                          (context) =>
                                              ZonaDetallesScreen(zona: zona),
                                    ),
                                  );
                                }
                              },
                            );
                          }).toSet();

                      final CameraPosition initialPosition = CameraPosition(
                        target: LatLng(defaultLat, defaultLng),
                        zoom: 8.2,
                      );

                      return Container(
                        width: 600,
                        child: GoogleMap(
                          initialCameraPosition: initialPosition,
                          markers: markers,
                          zoomControlsEnabled: true,
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
