import 'dart:io';
import 'dart:convert';
import 'package:frontend_psw/models/objects/album.dart';
import 'package:frontend_psw/models/support/app_constants.dart';
import 'package:frontend_psw/models/support/ErrorListener.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;


enum TypeHeader {
  json,
  urlencoded
}


class RestManager {
  ErrorListener? delegate;
  String? token;


  Future<List<Album>> getAlbumByArtistaAndNome(String artista, String nome) async {
    String url = '${AppConstants.baseURl}${AppConstants.albumsCercaArtistaNome}?artista=$artista&nome=$nome';
    final response= await http.get(Uri.parse(url));

    var responseData= json.decode(response.body);
    List<Album> albums = [];
    for(var albumData in responseData) {
      albums.add(Album.fromJson(albumData));
    }
    return albums;
  }

  Future<Album> getAlbumById(int? id) async {
    String url = '${AppConstants.baseURl}${AppConstants.albumsGetByID}?id=$id';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      return Album.fromJson(responseData);
    } else {
      throw Exception('Failed to load album');
    }
  }


}