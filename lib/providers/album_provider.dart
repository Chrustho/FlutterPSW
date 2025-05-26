import 'package:flutter/foundation.dart';
import '../models/album.dart';
import '../services/api_services.dart';
import '../services/api_services.dart';

class AlbumProvider with ChangeNotifier {
  List<Album> _albums = [];
  List<Album> _filteredAlbums = [];
  List<Album> _favoriteAlbums = [];
  bool _isLoading = false;
  String _error = '';
  String _searchQuery = '';

  List<Album> get albums => _albums;
  List<Album> get filteredAlbums => _filteredAlbums;
  List<Album> get favoriteAlbums => _favoriteAlbums;
  bool get isLoading => _isLoading;
  String get error => _error;
  String get searchQuery => _searchQuery;

  Future<void> loadAlbums() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _albums = await ApiService.getAllAlbums();
      _filteredAlbums = _albums;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchAlbums(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredAlbums = _albums;
    } else {
      _filteredAlbums = _albums.where((album) {
        return album.nome.toLowerCase().contains(query.toLowerCase()) ||
            album.artista.nome.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  void toggleFavorite(Album album) {
    if (_favoriteAlbums.any((fav) => fav.id == album.id)) {
      _favoriteAlbums.removeWhere((fav) => fav.id == album.id);
    } else {
      _favoriteAlbums.add(album);
    }
    notifyListeners();
  }

  bool isFavorite(Album album) {
    return _favoriteAlbums.any((fav) => fav.id == album.id);
  }

  void clearError() {
    _error = '';
    notifyListeners();
  }
}