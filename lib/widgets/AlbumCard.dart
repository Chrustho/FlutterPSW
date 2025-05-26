import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/objects/album.dart';

class AlbumCard extends StatelessWidget {
  final Album album;

  const AlbumCard({required this.album});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => AlbumDetailPage(albumId: album.id),
        ));
      },
      child: Container(
        width: 140,
        margin: EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Simulazione cover
            Container(
              height: 120,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[800],
              ),
              child: Icon(Icons.album, size: 60),
            ),
            SizedBox(height: 8),
            Text(album.nome, maxLines: 1, overflow: TextOverflow.ellipsis),
            Text(album.artista.nome, style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
