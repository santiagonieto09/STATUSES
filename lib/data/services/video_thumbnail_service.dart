import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

/// Genera y cachea en disco miniaturas JPEG para archivos de video.
/// Usa un mapa de Futures en vuelo para evitar generar el mismo thumbnail
/// dos veces cuando múltiples widgets lo solicitan simultáneamente.
class VideoThumbnailService {
  static final VideoThumbnailService _instance = VideoThumbnailService._();
  static VideoThumbnailService get instance => _instance;
  VideoThumbnailService._();

  static const _cacheDir = 'video_thumbnails';

  final Map<String, Future<String?>> _pending = {};

  /// Devuelve la ruta del thumbnail en caché, generándolo si no existe.
  Future<String?> getThumbnail(String videoPath) {
    return _pending[videoPath] ??= _generate(videoPath);
  }

  Future<String?> _generate(String videoPath) async {
    try {
      final base = await getTemporaryDirectory();
      final dir = Directory('${base.path}/$_cacheDir');
      if (!dir.existsSync()) dir.createSync(recursive: true);

      final name = '${p.basenameWithoutExtension(videoPath)}.jpg';
      final thumbFile = File('${dir.path}/$name');

      if (thumbFile.existsSync()) return thumbFile.path;

      final bytes = await VideoThumbnail.thumbnailData(
        video: videoPath,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 300,
        quality: 75,
      );

      if (bytes == null || bytes.isEmpty) return null;
      await thumbFile.writeAsBytes(bytes);
      return thumbFile.path;
    } catch (_) {
      return null;
    }
  }
}
