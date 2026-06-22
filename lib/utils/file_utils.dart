enum MediaType { image, video, audio, unknown }

class FileUtils {
  static const Set<String> imageExtensions = {
    '.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp',
  };

  static const Set<String> videoExtensions = {
    '.mp4', '.avi', '.mkv', '.mov', '.3gp', '.webm',
  };

  static const Set<String> audioExtensions = {
    '.mp3', '.aac', '.wav', '.m4a', '.ogg', '.opus',
  };

  static MediaType detectMediaType(String extension) {
    final ext = extension.toLowerCase();
    if (imageExtensions.contains(ext)) return MediaType.image;
    if (videoExtensions.contains(ext)) return MediaType.video;
    if (audioExtensions.contains(ext)) return MediaType.audio;
    return MediaType.unknown;
  }

  static String mimeTypeFromExtension(String extension) {
    final ext = extension.toLowerCase();
    switch (ext) {
      case '.jpg': case '.jpeg': return 'image/jpeg';
      case '.png': return 'image/png';
      case '.gif': return 'image/gif';
      case '.webp': return 'image/webp';
      case '.mp4': return 'video/mp4';
      case '.3gp': return 'video/3gpp';
      case '.mkv': return 'video/x-matroska';
      case '.avi': return 'video/x-msvideo';
      case '.mov': return 'video/quicktime';
      case '.mp3': return 'audio/mpeg';
      case '.aac': return 'audio/aac';
      case '.wav': return 'audio/wav';
      case '.m4a': return 'audio/mp4';
      case '.ogg': return 'audio/ogg';
      case '.opus': return 'audio/opus';
      default: return 'application/octet-stream';
    }
  }

  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}
