import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_psw/models/objects/recensione_album.dart';

class RecensioneCard extends StatelessWidget {
  final RecensioneAlbum recensione;

  const RecensioneCard({super.key, required this.recensione});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(recensione.user!.nome, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(recensione.testo),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                SizedBox(width: 4),
                Text('${recensione.voto}/5'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
