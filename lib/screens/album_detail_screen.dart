import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/support/app_constants.dart';
import '../models/objects/album.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/star_rating_widget.dart';

class AlbumDetailScreen extends StatelessWidget {
  final Album album;

  const AlbumDetailScreen({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Album Details',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAlbumCover(),
                SizedBox(width: 32),
                Expanded(child: _buildAlbumInfo()),
              ],
            ),
            SizedBox(height: 32),
            _buildActionsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAlbumCover() {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: Color(AppConstants.primaryColorHex),
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        child: _buildDetailImageWidget(),
      ),
    );
  }

  Widget _buildDetailImageWidget() {
    return FutureBuilder<bool>(
      future: _checkImageExists(album.coverUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildDetailPlaceholderCover();
        }

        final imageExists = snapshot.data ?? false;

        if (imageExists) {
          return Image.asset(
            album.coverUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _buildDetailPlaceholderCover();
            },
          );
        } else {
          return _buildDetailPlaceholderCover();
        }
      },
    );
  }

  Widget _buildDetailPlaceholderCover() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color(AppConstants.primaryColorHex),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(AppConstants.orangeColorHex),
              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
            ),
            child: Center(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _checkImageExists(String imagePath) async {
    try {
      // Prova diverse estensioni se l'immagine non ha estensione
      if (!AppConstants.supportedImageExtensions.any((ext) => imagePath.contains(ext))) {
        for (String extension in AppConstants.supportedImageExtensions) {
          try {
            await rootBundle.load('$imagePath$extension');
            return true;
          } catch (e) {
            continue;
          }
        }
        return false;
      } else {
        await rootBundle.load(imagePath);
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Widget _buildAlbumInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          album.nome,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(AppConstants.darkColorHex),
          ),
        ),
        SizedBox(height: 8),
        Text(
          album.artista.nome,
          style: TextStyle(
            fontSize: AppConstants.titleFontSize,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 16),
        StarRatingWidget(
          rating: 5,
          starSize: 28,
          showRatingText: true,
        ),
        SizedBox(height: 16),
        Text(
          'Genres',
          style: TextStyle(
            fontSize: AppConstants.subtitleFontSize,
            fontWeight: FontWeight.bold,
            color: Color(AppConstants.darkColorHex),
          ),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: album.generi.map((genre) {
            return Chip(
              label: Text(genre.nome),
              backgroundColor: Color(AppConstants.primaryColorHex).withOpacity(0.1),
              labelStyle: TextStyle(
                color: Color(AppConstants.primaryColorHex),
                fontWeight: FontWeight.bold,
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 16),
        Text(
          'Description',
          style: TextStyle(
            fontSize: AppConstants.subtitleFontSize,
            fontWeight: FontWeight.bold,
            color: Color(AppConstants.darkColorHex),
          ),
        ),
        SizedBox(height: 8),
        Text(
          album.nome,
          style: TextStyle(
            fontSize: AppConstants.bodyFontSize,
            color: Colors.grey[700],
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildActionsSection() {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // Implementa scrittura recensione
          },
          icon: Icon(Icons.edit, color: Colors.white),
          label: Text(
            'Write a Review',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(AppConstants.primaryColorHex),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
            ),
          ),
        ),
        SizedBox(width: 16),
        OutlinedButton.icon(
          onPressed: () {
            // Implementa aggiunta ai preferiti
          },
          icon: Icon(
            Icons.favorite_border,
            color: Color(AppConstants.primaryColorHex),
          ),
          label: Text(
            'Add to Favorites',
            style: TextStyle(color: Color(AppConstants.primaryColorHex)),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Color(AppConstants.primaryColorHex)),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
            ),
          ),
        ),
        SizedBox(width: 16),
        OutlinedButton.icon(
          onPressed: () {
            // Implementa condivisione
          },
          icon: Icon(
            Icons.share,
            color: Color(AppConstants.darkColorHex),
          ),
          label: Text(
            'Share',
            style: TextStyle(color: Color(AppConstants.darkColorHex)),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.grey),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
            ),
          ),
        ),
      ],
    );
  }
}
