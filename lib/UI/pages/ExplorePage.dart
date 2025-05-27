import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_psw/models/support/app_constants.dart';
import 'dart:convert';

import '../../models/managers/RestManager.dart';
import '../../models/objects/album.dart';
import '../../models/objects/genere.dart';
import '../../widgets/AlbumCard.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String _query = '';
  Genere? _selectedGenre;
  int? _selectedYear;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Cerca album, artista...',
            border: InputBorder.none,
            icon: Icon(Icons.search),
          ),
          onChanged: (val) => setState(() => _query = val),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterSheet(),
          ),
        ],
      ),
      body: FutureBuilder(
        future: RestManager().makeGetRequest(AppConstants.baseURl,
            '$AppConstants.albumsCercaArtistaNome?nome=$_query'),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final results = snap.data as List<Album>;
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (c, i) => AlbumCard(album: results[i]),
          );
        },
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder<List<Genere>>(
                future: RestManager()
                    .makeGetRequest(
                    AppConstants.baseURl, AppConstants.genresEdnpoint)
                    .then((response) =>
                    (jsonDecode(response) as List)
                        .map((item) => Genere.fromJson(item))
                        .toList()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  final generi = snapshot.data ?? [];
                  return DropdownButton<Genere>(
                    hint: Text('Seleziona genere'),
                    value: _selectedGenre,
                    items: generi.map((g) =>
                        DropdownMenuItem(value: g, child: Text(g.nome))
                    ).toList(),
                    onChanged: (g) => setState(() => _selectedGenre = g),
                  );
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Anno'),
                keyboardType: TextInputType.number,
                onChanged: (v) => setState(() => _selectedYear = int.tryParse(v)),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                child: Text('Applica'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
