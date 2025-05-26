import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/acquisto.dart';
import '../models/album.dart';
import '../models/artista.dart';
import '../models/canzone.dart';
import '../models/genere.dart';
import '../models/recensione_album.dart';
import '../models/users.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8080';
  static const Duration timeout = Duration(seconds: 30);

  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Album Services
  static Future<List<Album>> getAllAlbums({
    int pageNumber = 0,
    int pageSize = 10,
    String sortBy = 'id',
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/albums/paged?pageNumber=$pageNumber&pageSize=$pageSize&sortBy=$sortBy'),
        headers: headers,
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((album) => Album.fromJson(album)).toList();
      } else if (response.statusCode == 204) {
        return [];
      }
      throw Exception('Errore nel caricamento degli album: ${response.statusCode}');
    } catch (e) {
      throw Exception('Errore di connessione: $e');
    }
  }

  static Future<List<Album>> searchAlbumsByArtistAndName(String artista, String nome) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/albums/search/by_artist_and_name?artista=${Uri.encodeComponent(artista)}&nome=${Uri.encodeComponent(nome)}'),
        headers: headers,
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((album) => Album.fromJson(album)).toList();
      } else if (response.statusCode == 204) {
        return [];
      }
      throw Exception('Errore nella ricerca: ${response.statusCode}');
    } catch (e) {
      throw Exception('Errore di connessione: $e');
    }
  }

  static Future<List<Album>> getMostVotedAlbums(double votoMin) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/albums/most_voted/by_avg?votomin=$votoMin'),
        headers: headers,
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((album) => Album.fromJson(album)).toList();
      } else if (response.statusCode == 204) {
        return [];
      }
      throw Exception('Errore nel caricamento degli album più votati: ${response.statusCode}');
    } catch (e) {
      throw Exception('Errore di connessione: $e');
    }
  }

  static Future<List<Album>> searchAlbumsByGenres(List<String> generi, bool tutti) async {
    try {
      final generiParam = generi.map((g) => 'generi=${Uri.encodeComponent(g)}').join('&');
      final response = await http.get(
        Uri.parse('$baseUrl/albums/search/by_generi?$generiParam&tutti=$tutti'),
        headers: headers,
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((album) => Album.fromJson(album)).toList();
      } else if (response.statusCode == 204) {
        return [];
      }
      throw Exception('Errore nella ricerca per generi: ${response.statusCode}');
    } catch (e) {
      throw Exception('Errore di connessione: $e');
    }
  }

  // Artist Services
  static Future<List<Artista>> searchArtistsByName(String nome) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/artists/search/by_name?nome=${Uri.encodeComponent(nome)}'),
        headers: headers,
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((artist) => Artista.fromJson(artist)).toList();
      } else if (response.statusCode == 204) {
        return [];
      }
      throw Exception('Errore nella ricerca artisti: ${response.statusCode}');
    } catch (e) {
      throw Exception('Errore di connessione: $e');
    }
  }

  static Future<List<Artista>> getMostPopularArtists(int minFollowers) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/artists/most_popular?minFollowers=$minFollowers'),
        headers: headers,
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((artist) => Artista.fromJson(artist)).toList();
      } else if (response.statusCode == 204) {
        return [];
      }
      throw Exception('Errore nel caricamento artisti popolari: ${response.statusCode}');
    } catch (e) {
      throw Exception('Errore di connessione: $e');
    }
  }

  // Songs Services
  static Future<List<Canzone>> searchSongsByName(String nome) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/songs/search/by_name?nome=${Uri.encodeComponent(nome)}'),
        headers: headers,
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((song) => Canzone.fromJson(song)).toList();
      } else if (response.statusCode == 204) {
        return [];
      }
      throw Exception('Errore nella ricerca canzoni: ${response.statusCode}');
    } catch (e) {
      throw Exception('Errore di connessione: $e');
    }
  }

  static Future<List<Canzone>> getTopRatedSongs(double minVoto) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/songs/search/top_rated?minVoto=$minVoto'),
        headers: headers,
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((song) => Canzone.fromJson(song)).toList();
      } else if (response.statusCode == 204) {
        return [];
      }
      throw Exception('Errore nel caricamento canzoni top rated: ${response.statusCode}');
    } catch (e) {
      throw Exception('Errore di connessione: $e');
    }
  }

  static Future<List<Canzone>> getMostListenedSongs() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/songs/most_listened'),
        headers: headers,
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((song) => Canzone.fromJson(song)).toList();
      } else if (response.statusCode == 204) {
        return [];
      }
      throw Exception('Errore nel caricamento canzoni più ascoltate: ${response.statusCode}');
    } catch (e) {
      throw Exception('Errore di connessione: $e');
    }
  }

  // Genres Services
  static Future<List<Genere>> searchGenresByPrefix(String prefisso) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/genres/search/by_prefix?prefisso=${Uri.encodeComponent(prefisso)}'),
        headers: headers,
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((genre) => Genere.fromJson(genre)).toList();
      } else if (response.statusCode == 204) {
        return [];
      }
      throw Exception('Errore nella ricerca generi: ${response.statusCode}');
    } catch (e) {
      throw Exception('Errore di connessione: $e');
    }
  }

  static Future<List<Genere>> getMostPopularGenres(int minAlbums) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/genres/most_popular?minAlbums=$minAlbums'),
        headers: headers,
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((genre) => Genere.fromJson(genre)).toList();
      } else if (response.statusCode == 204) {
        return [];
      }
      throw Exception('Errore nel caricamento generi popolari: ${response.statusCode}');
    } catch (e) {
      throw Exception('Errore di connessione: $e');
    }
  }

  // Review Services
  static Future<List<RecensioneAlbum>> getAlbumReviewsByUser(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/album_reviews/user/$userId'),
        headers: headers,
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((review) => RecensioneAlbum.fromJson(review)).toList();
      } else if (response.statusCode == 204) {
        return [];
      }
      throw Exception('Errore nel caricamento recensioni utente: ${response.statusCode}');
    } catch (e) {
      throw Exception('Errore di connessione: $e');
    }
  }

  static Future<RecensioneAlbum> createAlbumReview(RecensioneAlbum recensione) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/album_reviews'),
        headers: headers,
        body: json.encode(recensione.toJson()),
      ).timeout(timeout);

      if (response.statusCode == 200) {
        return RecensioneAlbum.fromJson(json.decode(response.body));
      }
      throw Exception('Errore nella creazione recensione: ${response.statusCode}');
    } catch (e) {
      throw Exception('Errore di connessione: $e');
    }
  }

  // Purchase Services
  static Future<String> createPurchase(Acquisto acquisto) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/purchases'),
        headers: headers,
        body: json.encode(acquisto.toJson()),
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['message'] ?? 'Acquisto completato!';
      }
      throw Exception('Errore nell\'acquisto: ${response.statusCode}');
    } catch (e) {
      throw Exception('Errore di connessione: $e');
    }
  }

  static Future<List<Acquisto>> getUserPurchases(Users user) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/purchases/${user.id}'),
        headers: headers,
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((purchase) => Acquisto.fromJson(purchase)).toList();
      } else if (response.statusCode == 204) {
        return [];
      }
      throw Exception('Errore nel caricamento acquisti: ${response.statusCode}');
    } catch (e) {
      throw Exception('Errore di connessione: $e');
    }
  }
}