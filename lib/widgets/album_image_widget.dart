import 'package:flutter/material.dart';
import '../models/support/app_constants.dart';
import '../models/objects/album.dart';
import '../utils/image_helper.dart';

class AlbumImageWidget extends StatelessWidget {
  final Album album;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxFit fit;

  const AlbumImageWidget({
    Key? key,
    required this.album,
    this.width,
    this.height,
    this.borderRadius,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: ImageHelper.getImagePathWithExtension(album.imageUrl ?? AppConstants.defaultAlbumCover),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingPlaceholder();
        }

        final imagePath = snapshot.data ?? AppConstants.defaultAlbumCover;

        if (imagePath == AppConstants.defaultAlbumCover) {
          return _buildPlaceholderCover();
        }

        return ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(AppConstants.defaultRadius),
          child: Image.asset(
            imagePath,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (context, error, stackTrace) {
              return _buildPlaceholderCover();
            },
          ),
        );
      },
    );
  }

  Widget _buildLoadingPlaceholder() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: borderRadius ?? BorderRadius.circular(AppConstants.defaultRadius),
      ),
      child: Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              Color(AppConstants.primaryColorHex),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderCover() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Color(AppConstants.primaryColorHex),
        borderRadius: borderRadius ?? BorderRadius.circular(AppConstants.defaultRadius),
      ),
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
                width: (width ?? 200) * 0.2,
                height: (height ?? 200) * 0.2,
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
}