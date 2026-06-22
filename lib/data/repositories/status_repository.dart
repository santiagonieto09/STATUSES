import 'dart:io';
import 'package:statuses/constants/app_constants.dart';
import 'package:statuses/data/models/status_file.dart';
import 'package:statuses/utils/file_utils.dart';

class StatusRepository {
  Future<List<String>> _discoverDirectories() async {
    final dirs = <String>[];
    for (final path in AppConstants.whatsappStatusPaths) {
      final dir = Directory(path);
      if (await dir.exists()) {
        dirs.add(path);
      }
    }
    return dirs;
  }

  Future<List<StatusFile>> loadStatuses() async {
    final dirs = await _discoverDirectories();
    if (dirs.isEmpty) return [];

    final files = <StatusFile>[];
    for (final dir in dirs) {
      final dirEntity = Directory(dir);
      if (!await dirEntity.exists()) continue;

      await for (final entity in dirEntity.list()) {
        if (entity is! File) continue;
        final file = entity;
        final name = file.uri.pathSegments.last;
        final ext = name.contains('.')
            ? '.${name.split('.').last.toLowerCase()}'
            : '';

        files.add(StatusFile(
          filePath: file.path,
          fileName: name,
          extension: ext,
          fileSize: await file.length(),
          lastModified: await file.lastModified(),
          mediaType: FileUtils.detectMediaType(ext),
        ));
      }
    }

    files.sort((a, b) => b.lastModified.compareTo(a.lastModified));
    return files;
  }

  Future<bool> hasStatusDirectory() async {
    final dirs = await _discoverDirectories();
    return dirs.isNotEmpty;
  }

  Future<void> copyToDirectory(StatusFile status, String destDir) async {
    final destFile = File('$destDir/${status.fileName}');
    final sourceFile = File(status.filePath);
    await sourceFile.copy(destFile.path);
  }
}
