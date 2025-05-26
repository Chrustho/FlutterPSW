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

  // addresses
  static final String ADDRESS_STORE_SERVER = "localhost:8082";
  static final String ADDRESS_AUTHENTICATION_SERVER = "***";

  // authentication
  static final String REALM = "***";
  static final String CLIENT_ID = "***";
  static final String CLIENT_SECRET = "***";
  static final String REQUEST_LOGIN = "/auth/realms/" + REALM + "/protocol/openid-connect/token";
  static final String REQUEST_LOGOUT = "/auth/realms/" + REALM + "/protocol/openid-connect/logout";

  // responses
  static final String RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS = "ERROR_MAIL_USER_ALREADY_EXISTS";

  // messages
  static final String MESSAGE_CONNECTION_ERROR = "connection_error";

  // links
  static final String LINK_RESET_PASSWORD = "***";
  static final String LINK_FIRST_SETUP_PASSWORD = "***";

  // requests
  static final String REQUEST_SEARCH_PRODUCTS = "/products/search/by_name";
  static final String REQUEST_ADD_USER = "/users";

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