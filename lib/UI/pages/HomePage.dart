import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_psw/models/support/app_constants.dart';

import '../../models/managers/RestManager.dart';
import '../../models/objects/album.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RestManager().makeGetRequest(AppConstants.ADDRESS_STORE_SERVER, "servicePath"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());

        if (snapshot.hasError)
          return Center(child: Text('Errore nel caricamento'));

        final albums = snapshot.data as List<Album>;

        return ListView(
          padding: EdgeInsets.all(16),
          children: [
            Text("Nuove Uscite", style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 8),
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: albums.length,
                itemBuilder: (context, index) {
                  final album = albums[index];
                  return AlbumCard(album: album);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
