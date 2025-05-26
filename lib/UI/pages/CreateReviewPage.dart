import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_psw/models/support/app_constants.dart';

import '../../models/managers/RestManager.dart';
import '../../models/objects/album.dart';

class CreateReviewPage extends StatefulWidget {
  @override
  _CreateReviewPageState createState() => _CreateReviewPageState();
}

class _CreateReviewPageState extends State<CreateReviewPage> {
  final _formKey = GlobalKey<FormState>();
  Album? _chosenAlbum;
  int _rating = 3;
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nuova Recensione')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Selezione album (potrebbe aprire una pagina di ricerca)
              DropdownButtonFormField<Album>(
                hint: Text('Scegli un album'),
                items: [], // popola con RestManager().getAllAlbums()
                onChanged: (a) => setState(() => _chosenAlbum = a),
                validator: (v) => v == null ? 'Seleziona un album' : null,
              ),
              SizedBox(height: 12),
              Slider(
                value: _rating.toDouble(),
                min: 1,
                max: 5,
                divisions: 4,
                label: '$_rating',
                onChanged: (v) => setState(() => _rating = v.toInt()),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Testo recensione'),
                maxLines: 5,
                onSaved: (v) => _text = v ?? '',
                validator: (v) => (v == null || v.isEmpty) ? 'Inserisci un testo' : null,
              ),
              Spacer(),
              ElevatedButton(
                child: Text('Invia'),
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    /*
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    RestManager().makePostRequest(AppConstants.ADDRESS_STORE_SERVER, "path", {
      albumId: _chosenAlbum!.id,
      voto: _rating,
      testo: _text,}
    ).then((_) {
      Navigator.pop(context);
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore nell\'invio')),
      );
    });

     */
  }
}
