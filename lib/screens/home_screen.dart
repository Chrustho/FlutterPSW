import 'package:flutter/material.dart';
import 'package:frontend_psw/models/artista.dart';
import 'package:frontend_psw/models/genere.dart';
import 'package:frontend_psw/services/api_services.dart';
import '../constants/app_constants.dart';
import '../models/album.dart';
import '../services/api_services.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/navigation_sidebar.dart';
import '../widgets/main_navigation.dart';
import '../widgets/album_card.dart';
import '../widgets/star_rating_widget.dart';
import 'album_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Album> albums = [];
  List<Album> filteredAlbums = [];
  List<Album> recommendedAlbums = [];
  bool isLoading = true;
  String selectedSidebarItem = 'albums';
  int selectedNavIndex = 0;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadAlbums();
  }

  /*
  Future<void> _loadAlbums() async {
    try {
      // Simulazione dati per demo
      final mockAlbums = [
        Album(
          id: 1,
          nome: 'SAMPLE ALBUM',
          annoRilascio: 20,
          artista: Artista(2, "ciao", generi: [new Genere(nome: "Rock")]),
          // imageUrl viene generato automaticamente: assets/images/albums/sample_album.jpg
          rating: 4.5,
          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          genres: ['Rock', 'Alternative'],
        ),
        Album(
          id: '2',
          title: 'Another Album Title',
          artist: 'Artist Name',
          // imageUrl viene generato automaticamente: assets/images/albums/another_album_title.jpg
          rating: 4.2,
          description: 'Great album with amazing tracks.',
          genres: ['Pop', 'Electronic'],
        ),
        Album(
          id: '3',
          title: 'Greatest Hits',
          artist: 'Famous Band',
          // imageUrl viene generato automaticamente: assets/images/albums/greatest_hits.jpg
          rating: 4.8,
          description: 'Collection of the best songs.',
          genres: ['Classic Rock'],
        ),
        Album(
          id: '4',
          title: 'MODERN SOUNDS',
          artist: 'Synthwave Artist',
          // imageUrl viene generato automaticamente: assets/images/albums/modern_sounds.jpg
          rating: 4.3,
          description: 'Modern electronic sounds and beats.',
          genres: ['Synthwave', 'Electronic'],
        ),
      ];

      setState(() {
        albums = mockAlbums;
        filteredAlbums = mockAlbums;
        recommendedAlbums = mockAlbums.take(3).toList();
        isLoading = false;
      });

      // Uncomment per usare API reale
      // final fetchedAlbums = await ApiService.fetchAlbums();
      // setState(() {
      //   albums = fetchedAlbums;
      //   filteredAlbums = fetchedAlbums;
      //   recommendedAlbums = fetchedAlbums.take(3).toList();
      //   isLoading = false;
      // });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading albums: $e')),
      );
    }
  }

   */

  void _onSearch(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredAlbums = albums;
      } else {
        filteredAlbums = albums.where((album) {
          return album.nome.toLowerCase().contains(query.toLowerCase()) ||
              album.artista.nome.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _onSidebarItemSelected(String item) {
    setState(() {
      selectedSidebarItem = item;
    });
    // Implementa logica per diversi tipi di contenuto
  }

  void _onNavItemSelected(int index) {
    setState(() {
      selectedNavIndex = index;
    });
    // Implementa navigazione principale
  }

  void _navigateToAlbumDetail(Album album) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AlbumDetailScreen(album: album),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'ALBUM REVIEWS'),
      body: Column(
        children: [
          MainNavigation(
            selectedIndex: selectedNavIndex,
            onItemSelected: _onNavItemSelected,
          ),
          SearchBarWidget(onSearch: _onSearch),
          Expanded(
            child: Row(
              children: [
                NavigationSidebar(
                  selectedItem: selectedSidebarItem,
                  onItemSelected: _onSidebarItemSelected,
                ),
                Expanded(
                  child: _buildMainContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (searchQuery.isEmpty) _buildFeaturedAlbum(),
          SizedBox(height: 32),
          if (searchQuery.isEmpty) _buildRecommendationsSection(),
          if (searchQuery.isNotEmpty) _buildSearchResults(),
        ],
      ),
    );
  }

  Widget _buildFeaturedAlbum() {
    if (albums.isEmpty) return SizedBox();

    final featuredAlbum = albums.first;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 300,
          child: AlbumCard(
            album: featuredAlbum,
            onTap: () => _navigateToAlbumDetail(featuredAlbum),
          ),
        ),
        SizedBox(width: 32),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                featuredAlbum.nome,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(AppConstants.darkColorHex),
                ),
              ),
              SizedBox(height: 8),
              Text(
                featuredAlbum.artista.nome,
                style: TextStyle(
                  fontSize: AppConstants.titleFontSize,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16),
              StarRatingWidget(
                rating: 2,
                starSize: 24,
                showRatingText: true,
              ),
              SizedBox(height: 16),
              Text(
                featuredAlbum.nome,
                style: TextStyle(
                  fontSize: AppConstants.subtitleFontSize,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Implementa scrittura recensione
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(AppConstants.primaryColorHex),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                  ),
                ),
                child: Text(
                  'Write a Review',
                  style: TextStyle(
                    fontSize: AppConstants.subtitleFontSize,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You Might Also Like',
          style: TextStyle(
            fontSize: AppConstants.titleFontSize,
            fontWeight: FontWeight.bold,
            color: Color(AppConstants.darkColorHex),
          ),
        ),
        SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: recommendedAlbums.length,
          itemBuilder: (context, index) {
            final album = recommendedAlbums[index];
            return AlbumCard(
              album: album,
              onTap: () => _navigateToAlbumDetail(album),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search Results (${filteredAlbums.length})',
          style: TextStyle(
            fontSize: AppConstants.titleFontSize,
            fontWeight: FontWeight.bold,
            color: Color(AppConstants.darkColorHex),
          ),
        ),
        SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.8,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: filteredAlbums.length,
          itemBuilder: (context, index) {
            final album = filteredAlbums[index];
            return AlbumCard(
              album: album,
              onTap: () => _navigateToAlbumDetail(album),
            );
          },
        ),
      ],
    );
  }
}