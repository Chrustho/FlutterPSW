import 'package:flutter/services.dart';
import '../models/support/app_constants.dart';

class ImageHelper {
  /// Verifica se un'immagine esiste nelle risorse
  static Future<bool> checkImageExists(String imagePath) async {
    try {
      // Se l'immagine ha già un'estensione, verifica direttamente
      if (AppConstants.supportedImageExtensions.any((ext) =>
          imagePath.contains(ext))) {
        await rootBundle.load(imagePath);
        return true;
      }

      // Altrimenti prova con tutte le estensioni supportate
      for (String extension in AppConstants.supportedImageExtensions) {
        try {
          await rootBundle.load('$imagePath$extension');
          return true;
        } catch (e) {
          continue;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Ottiene il path completo dell'immagine con l'estensione corretta
  static Future<String> getImagePathWithExtension(String basePath) async {
    // Se ha già un'estensione, ritorna così com'è
    if (AppConstants.supportedImageExtensions.any((ext) =>
        basePath.contains(ext))) {
      return basePath;
    }

    // Prova con tutte le estensioni supportate
    for (String extension in AppConstants.supportedImageExtensions) {
      try {
        await rootBundle.load('$basePath$extension');
        return '$basePath$extension';
      } catch (e) {
        continue;
      }
    }

    // Se non trova nessuna immagine, ritorna il path di default
    return AppConstants.defaultAlbumCover;
  }

  /// Sanitizza il nome dell'album per creare un nome file valido
  static String sanitizeAlbumTitle(String title) {
    return title
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s-]'), '') // Rimuove caratteri speciali
        .replaceAll(RegExp(r'\s+'), '_') // Sostituisce spazi con underscore
        .replaceAll(RegExp(r'_+'), '_');
  } // Evita underscore multipli
}