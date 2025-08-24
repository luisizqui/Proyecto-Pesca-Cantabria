import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pesca_cantabria/models/zona.dart';
import 'package:pesca_cantabria/models/peces_zona.dart';
import 'package:pesca_cantabria/controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pesca_cantabria/enums/meses.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pesca_cantabria/screens/pez_detalles_screen.dart';

class ZonaDetallesScreen extends StatefulWidget {
  final Zona zona;
  const ZonaDetallesScreen({super.key, required this.zona});

  @override
  State<ZonaDetallesScreen> createState() => _ZonaDetallesScreenState();
}

class _ZonaDetallesScreenState extends State<ZonaDetallesScreen> {
  late Future<List<Peceszona>> _pecesFuture;

  @override
  void initState() {
    super.initState();
    _pecesFuture = Controller.fetchPecesZonaZonaId(widget.zona.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.zona.nombre,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            CachedNetworkImage(
              imageUrl:
                  widget.zona.imageurl != null ? Controller.getImageUrl(widget.zona.imageurl!):
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Llao_Llao_Peninsula.jpg/1200px-Llao_Llao_Peninsula.jpg',
              placeholder: (context, url) => const CircularProgressIndicator(),
              width: kIsWeb ? 600:  300,
              height:kIsWeb ? 300: 150,
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 250,
                width: 600,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.zona.latitud, widget.zona.longitud),
                    zoom: 13,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId(widget.zona.id.toString()),
                      position: LatLng(
                        widget.zona.latitud,
                        widget.zona.longitud,
                      ),
                      infoWindow: InfoWindow(title: widget.zona.nombre),
                    ),
                  },
                  zoomControlsEnabled: true,
                ),
              ),
            ),
            const Text(
              'Peces en esta zona',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            FutureBuilder<List<Peceszona>>(
              future: _pecesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Center(child: Text('Error: ${snapshot.error}')),
                  );
                } else {
                  final peces = snapshot.data!.map((pz) => pz.pez).toList();
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: peces.length,
                    itemBuilder: (context, index) {
                      final pez = peces[index];
                      return GestureDetector(
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => PezDetallesScreen(pez: pez),
                              ),
                            ),
                   child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 5,
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 1, 10, 10),
                            child: Column(
                              children: [
                                Text(
                                  pez.nombre,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  pez.nombreCientifico,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (pez.talla != 0)
                                          Text('Talla mínima: ${pez.talla}cm'),
                                          Text(
                                            'Inicio veda:\n ${pez.fini.day} de ${meses[pez.fini.month]}',
                                          ),
                                          Text(
                                            pez.ffin.year != 9999
                                                ? 'Fin veda: \n ${pez.ffin.day} de ${meses[pez.ffin.month]}'
                                                : 'Fin veda:\n Hasta alcanzar cupo',
                                          ),
                                      ],
                                    ),
                                  CachedNetworkImage(
                                    imageUrl:
                                        pez.imageurl != null ? Controller.getImageUrl(pez.imageurl!) :
                                        'https://plus.unsplash.com/premium_photo-1722908885987-628cef023cc9?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGV6JTIwbmVtb3xlbnwwfHwwfHx8MA%3D%3D',
                                      placeholder:
                                          (context, url) =>
                                              const CircularProgressIndicator(),
                                      width: 115,
                                      height: 100,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ],
                                ),
                                if (pez.notas.isNotEmpty)
                                  Text('Notas:\n ${pez.notas}'),
                              ],
                            ),
                          ),
                        ),
                      )));
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
