import 'package:flutter/material.dart';
import 'package:frontend_psw/models/objects/recensione_album.dart';
import 'package:frontend_psw/models/support/app_constants.dart';

import '../../models/managers/RestManager.dart';
import '../../models/objects/album.dart';
import '../../widgets/RecensioneCard.dart';

class AlbumDetailPage extends StatelessWidget {
  final int albumId;

  const AlbumDetailPage({super.key, required this.albumId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RestManager().makeGetRequest(AppConstants.baseURl, '$AppConstants.albumsGetByID?id=$albumId'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('Errore')));
        }

        final album = snapshot.data as Album;

        return Scaffold(
          appBar: AppBar(title: Text(album.nome)),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(album.artista.nome, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                SizedBox(height: 12),
                Text("Canzoni", style: Theme.of(context).textTheme.titleLarge),
                ...album.canzoni.map((canzone) => ListTile(
                  title: Text(canzone.nome),
                  subtitle: Text('${canzone.durata} sec'),
                )),
                SizedBox(height: 12),
                Text("Recensioni", style: Theme.of(context).textTheme.titleLarge),
                FutureBuilder(
                  future: RestManager().makeGetRequest(AppConstants.baseURl, '$AppConstants.albumsGetByID{$albumId}'),
                  builder: (context, recSnapshot) {
                    if (!recSnapshot.hasData) return CircularProgressIndicator();
                    final recensioni = recSnapshot.data as List<RecensioneAlbum>;
                    return Column(
                      children: recensioni.map((r) => RecensioneCard(recensione: r)).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
