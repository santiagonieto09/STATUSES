import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:statuses/data/models/status_file.dart';
import 'package:statuses/utils/file_utils.dart';

class SafService {
  static const _channel = MethodChannel('com.statuses.statuses/saf');
  static const String _safCacheDir = 'saf_statuses_cache';
  static const int _cacheStaleThresholdMs = 1000;

  Future<Uri?> getGrantedUri() async {
    try {
      final List<dynamic>? perms =
          await _channel.invokeMethod('getPersistedPermissions');
      if (perms == null || perms.isEmpty) return null;

      for (final perm in perms) {
        final uriStr = (perm['uri'] as String? ?? '').toLowerCase();
        final isRead = perm['isRead'] as bool? ?? false;
        if (isRead &&
            (uriStr.contains('com.whatsapp') ||
                uriStr.contains('.statuses'))) {
          return Uri.parse(perm['uri'] as String);
        }
      }
    } on PlatformException {
      // Puede fallar en plataformas no-Android; se ignora silenciosamente
    }
    return null;
  }

  Future<Uri?> requestPermission() async {
    try {
      final String? uriString =
          await _channel.invokeMethod('openDocumentTree');
      if (uriString == null) return null;
      return Uri.parse(uriString);
    } on PlatformException {
      return null;
    }
  }

  Future<List<StatusFile>> loadStatuses(Uri treeUri) async {
    final List<dynamic>? rawFiles = await _channel.invokeMethod(
      'listFiles',
      {'uri': treeUri.toString()},
    );
    if (rawFiles == null || rawFiles.isEmpty) return [];

    final cacheDir = await _ensureCacheDir();
    final result = <StatusFile>[];

    for (final raw in rawFiles) {
      final name = raw['name'] as String? ?? '';
      if (name.isEmpty) continue;

      final safeName = p.basename(name);
      final ext = name.contains('.')
          ? '.${name.split('.').last.toLowerCase()}'
          : '';
      final mediaType = FileUtils.detectMediaType(ext);
      if (mediaType == MediaType.unknown) continue;

      final fileUri = raw['uri'] as String;
      final fileSize = (raw['size'] as num?)?.toInt() ?? 0;
      final lastModifiedMs = (raw['lastModified'] as num?)?.toInt() ?? 0;

      final cachedFile = File('${cacheDir.path}/$safeName');

      bool needsCopy = true;
      if (await cachedFile.exists()) {
        final existingLastModified =
            (await cachedFile.lastModified()).millisecondsSinceEpoch;
        needsCopy = (lastModifiedMs - existingLastModified).abs() > _cacheStaleThresholdMs;
      }

      if (needsCopy) {
        try {
          await _channel.invokeMethod('copyFileToCache', {
            'uri': fileUri,
            'destPath': cachedFile.path,
          });
        } on PlatformException {
          continue;
        }
      }

      if (!await cachedFile.exists()) continue;

      result.add(StatusFile(
        filePath: cachedFile.path,
        fileName: name,
        extension: ext,
        fileSize: fileSize > 0 ? fileSize : await cachedFile.length(),
        lastModified: lastModifiedMs > 0
            ? DateTime.fromMillisecondsSinceEpoch(lastModifiedMs)
            : await cachedFile.lastModified(),
        mediaType: mediaType,
      ));
    }

    result.sort((a, b) => b.lastModified.compareTo(a.lastModified));
    return result;
  }

  Future<void> releasePermission(Uri uri) async {
    try {
      await _channel.invokeMethod('releasePermission', {'uri': uri.toString()});
    } on PlatformException {
      // Se ignora si ya no existe el permiso
    }
  }

  Future<void> clearCache() async {
    final base = await getTemporaryDirectory();
    final dir = Directory('${base.path}/$_safCacheDir');
    if (await dir.exists()) await dir.delete(recursive: true);
  }

  Future<Directory> _ensureCacheDir() async {
    final base = await getTemporaryDirectory();
    final dir = Directory('${base.path}/$_safCacheDir');
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }
}
