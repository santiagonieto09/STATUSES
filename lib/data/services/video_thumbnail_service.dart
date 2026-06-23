import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoThumbnailService {
  static final VideoThumbnailService _instance = VideoThumbnailService._();
  static VideoThumbnailService get instance => _instance;
  VideoThumbnailService._();

  static const _cacheDir = 'video_thumbnails';
  static const _fallbackDir = 'video_thumbnails_fallback';

  final Map<String, Future<String?>> _pending = {};

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

      var bytes = await compute(_generateThumbnail, videoPath);

      if (bytes == null || bytes.isEmpty) {
        bytes = await _generateWithFallback(videoPath);
      }

      if (bytes == null || bytes.isEmpty) {
        _pending.remove(videoPath);
        debugPrint('VideoThumbnailService: no se pudo generar thumbnail para $videoPath');
        return null;
      }

      await thumbFile.writeAsBytes(bytes);
      return thumbFile.path;
    } catch (e, st) {
      _pending.remove(videoPath);
      debugPrint('VideoThumbnailService: error al generar thumbnail para $videoPath: $e\n$st');
      return null;
    }
  }

  Future<Uint8List?> _generateWithFallback(String videoPath) async {
    try {
      final base = await getTemporaryDirectory();
      final fallbackDir = Directory('${base.path}/$_fallbackDir');
      if (!fallbackDir.existsSync()) fallbackDir.createSync(recursive: true);

      final sourceFile = File(videoPath);
      if (!sourceFile.existsSync()) return null;

      final tempVideo = File(
        '${fallbackDir.path}/${p.basename(videoPath)}',
      );

      await sourceFile.copy(tempVideo.path);

      final bytes = await VideoThumbnail.thumbnailData(
        video: tempVideo.path,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 300,
        quality: 75,
      );

      tempVideo.deleteSync();

      return bytes;
    } catch (e, st) {
      debugPrint('VideoThumbnailService: fallback falló para $videoPath: $e\n$st');
      return null;
    }
  }
}

Future<Uint8List?> _generateThumbnail(String videoPath) async {
  try {
    return await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 300,
      quality: 75,
    );
  } catch (e) {
    debugPrint('VideoThumbnailService isolate: error $e');
    return null;
  }
}
