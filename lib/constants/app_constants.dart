class AppConstants {
  // Colors
  static const int primaryColorHex = 0xFF1DB584;
  static const int orangeColorHex = 0xFFFF9500;
  static const int darkColorHex = 0xFF2C3E50;
  static const int lightGrayHex = 0xFFF8F9FA;

  // API Endpoints (placeholder)
  static const String baseUrl = 'https://api.placeholder.com';
  static const String albumsEndpoint = '/albums';
  static const String artistsEndpoint = '/artists';
  static const String reviewsEndpoint = '/reviews';

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 8.0;
  static const double defaultElevation = 2.0;

  // Text Styles
  static const double titleFontSize = 24.0;
  static const double subtitleFontSize = 16.0;
  static const double bodyFontSize = 14.0;

  // Assets Path
  static const String albumCoversPath = 'assets/images/albums/';
  static const String defaultAlbumCover = 'assets/images/default_album.png';

  // Supported image extensions
  static const List<String> supportedImageExtensions = [
    '.jpg', '.jpeg', '.png', '.webp', '.gif'
  ];
}