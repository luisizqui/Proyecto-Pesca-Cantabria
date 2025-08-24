import 'package:flutter/material.dart';
import 'package:pesca_cantabria/controller.dart';
import 'package:pesca_cantabria/enums/meses.dart';
import 'package:pesca_cantabria/models/pez.dart';
import 'package:pesca_cantabria/screens/pez_detalles_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PecesScreen extends StatefulWidget {
  const PecesScreen({super.key});

  @override
  State<PecesScreen> createState() => _PecesScreenState();
}

class _PecesScreenState extends State<PecesScreen> {
  late Future<List<Pez>> _pecesFuture;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _pecesFuture = Controller.fetchPeces();
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
                  labelText: 'Buscar pez',
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
            child: FutureBuilder<List<Pez>>(
              future: _pecesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final peces =
                      snapshot.data!
                          .where(
                            (pez) =>
                                pez.nombre.toLowerCase().contains(_searchText),
                          )
                          .toList();
                  return ListView.builder(
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
                                padding: const EdgeInsets.fromLTRB(
                                  10,
                                  1,
                                  10,
                                  10,
                                ),
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
                                              Text(
                                                'Talla mínima: ${pez.talla}cm',
                                              ),
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
                                              pez.imageurl != null
                                                  ? Controller.getImageUrl(
                                                    pez.imageurl!,
                                                  )
                                                  : 'https://plus.unsplash.com/premium_photo-1722908885987-628cef023cc9?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGV6JTIwbmVtb3xlbnwwfHwwfHx8MA%3D%3D',
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
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('Notas:\n ${pez.notas}'),
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
