import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_psw/widgets/star_rating_widget.dart';
import '../models/support/app_constants.dart';
import '../models/objects/album.dart';
import 'album_image_widget.dart';

class AlbumCard extends StatelessWidget {
  final Album album;
  final VoidCallback? onTap;
  final bool showDescription;

  const AlbumCard({
    super.key,
    required this.album,
    this.onTap,
    this.showDescription = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(AppConstants.defaultPadding / 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAlbumCover(),
            Padding(
              padding: EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    album.nome,
                    style: TextStyle(
                      fontSize: AppConstants.subtitleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Color(AppConstants.darkColorHex),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    album.artista.nome,
                    style: TextStyle(
                      fontSize: AppConstants.bodyFontSize,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  StarRatingWidget(
                    rating: album.getRating(album.nome),
                    starSize: 16,
                    showRatingText: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlbumCover() {
    return Container(
      height: 200,
      child: AlbumImageWidget(
        album: album,
        width: double.infinity,
        height: 200,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.defaultRadius),
        ),
      ),
    );
  }
  Future<bool> checkImageExists(String imagePath) async {
    try {
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
}
