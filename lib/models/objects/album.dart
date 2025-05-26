import 'artista.dart';
import 'canzone.dart';
import 'genere.dart';

class Album {
  final int? id;
  final String nome;
  final int? annoRilascio;
  final Artista artista;
  final List<Canzone> canzoni;
  final List<Genere> generi;
  final double? prezzo;
  final int? quantity;

  Album({
    this.id,
    required this.nome,
    this.annoRilascio,
    required this.artista,
    this.canzoni = const [],
    this.generi = const [],
    this.prezzo,
    this.quantity,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      nome: json['nome'] ?? '',
      annoRilascio: json['annoRilascio'],
      artista: Artista.fromJson(json['artista'] ?? {}),
      canzoni: (json['canzoni'] as List?)?.map((c) => Canzone.fromJson(c)).toList() ?? [],
      generi: (json['generi'] as List?)?.map((g) => Genere.fromJson(g)).toList() ?? [],
      prezzo: json['prezzo']?.toDouble(),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'annoRilascio': annoRilascio,
      'artista': artista.toJson(),
      'canzoni': canzoni.map((c) => c.toJson()).toList(),
      'generi': generi.map((g) => g.toJson()).toList(),
      'prezzo': prezzo,
      'quantity': quantity,
    };
  }

  // Genera URL copertina basato su nome album e artista
  String get coverUrl {
    final artistName = artista.nome.replaceAll(' ', '%20');
    final albumName = nome.replaceAll(' ', '%20');
    return 'https://api.deezer.com/search/album?q=artist:"$artistName"%20album:"$albumName"&limit=1';
  }

  // URL placeholder per copertina
  String get placeholderCover {
    return 'https://via.placeholder.com/300x300/6366f1/ffffff?text=${nome.substring(0, 1)}';
  }
}