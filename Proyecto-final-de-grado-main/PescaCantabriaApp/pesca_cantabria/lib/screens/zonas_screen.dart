import 'package:flutter/material.dart';
import 'package:pesca_cantabria/controller.dart';
import 'package:pesca_cantabria/models/zona.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pesca_cantabria/screens/zona_detalles_screen.dart';

class ZonasScreen extends StatefulWidget {
  const ZonasScreen({super.key});

  @override
  State<ZonasScreen> createState() => _ZonasScreenState();
}

class _ZonasScreenState extends State<ZonasScreen> {
  late Future<List<Zona>> _zonasFuture;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _zonasFuture = Controller.fetchZonas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Buscar zona',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchText = value.toLowerCase();
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Zona>>(
              future: _zonasFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final zonas =
                      snapshot.data!
                          .where(
                            (zona) =>
                                zona.nombre.toLowerCase().contains(_searchText),
                          )
                          .toList();
                  return ListView.builder(
                    itemCount: zonas.length,
                    itemBuilder: (context, index) {
                      final zona = zonas[index];
                      return GestureDetector(
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => ZonaDetallesScreen(zona: zona),
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
                                padding: const EdgeInsets.fromLTRB(
                                  10,
                                  1,
                                  10,
                                  10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      zona.nombre,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    CachedNetworkImage(
                                      imageUrl:
                                          zona.imageurl != null
                                              ? Controller.getImageUrl(
                                                zona.imageurl!,
                                              )
                                              : 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Llao_Llao_Peninsula.jpg/1200px-Llao_Llao_Peninsula.jpg',
                                      placeholder:
                                          (context, url) =>
                                              const CircularProgressIndicator(),
                                      width: 600,
                                      height: 100,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
