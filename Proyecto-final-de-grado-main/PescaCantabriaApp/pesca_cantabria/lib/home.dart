import 'package:flutter/material.dart';

import 'package:pesca_cantabria/screens/map_screen.dart';
import 'package:pesca_cantabria/screens/peces_screen.dart';
import 'package:pesca_cantabria/screens/zonas_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget? navPage;
    if (_selectedIndex == 0) {
      navPage = PecesScreen();
    } else if (_selectedIndex == 1) {
      navPage = ZonasScreen();
    } else if (_selectedIndex == 2) {
      navPage = MapScreen();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', fit: BoxFit.cover, height: 90),
            const Text('Pesca Cantabria'),
          ],
        ),
      ),
      body: Center(
        child: Container(padding: const EdgeInsets.all(16.0), child: navPage),
      ),
      bottomNavigationBar:        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Flexible(
          child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 600),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.phishing), label: 'Peces'),
            BottomNavigationBarItem(icon: Icon(Icons.water), label: 'Zonas'),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
      )],));
  }
}
