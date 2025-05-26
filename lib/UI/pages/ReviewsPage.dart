import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_psw/models/support/app_constants.dart';

import '../../models/managers/RestManager.dart';
import '../../models/objects/recensione_album.dart';
import '../../widgets/RecensioneCard.dart';

class ReviewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Le mie recensioni')),
      body: FutureBuilder(
        future: RestManager().makeGetRequest(AppConstants.ADDRESS_STORE_SERVER, "servicePath"),
        builder: (c, snap) {
          if (snap.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          final recs = snap.data as List<RecensioneAlbum>;
          return ListView(
            padding: EdgeInsets.all(16),
            children: recs.map((r) => RecensioneCard(recensione: r)).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CreateReviewPage()),
        ),
      ),
    );
  }
}
