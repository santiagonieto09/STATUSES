import 'package:flutter_test/flutter_test.dart';
import 'package:statuses/data/models/status_file.dart';
import 'package:statuses/utils/file_utils.dart';

void main() {
  group('StatusFile', () {
    final now = DateTime.now();

    test('creates with correct properties', () {
      final status = StatusFile(
        filePath: '/path/to/file.jpg',
        fileName: 'file.jpg',
        extension: '.jpg',
        fileSize: 1024,
        lastModified: now,
        mediaType: MediaType.image,
      );

      expect(status.filePath, '/path/to/file.jpg');
      expect(status.fileName, 'file.jpg');
      expect(status.extension, '.jpg');
      expect(status.fileSize, 1024);
      expect(status.lastModified, now);
      expect(status.mediaType, MediaType.image);
    });

    test('fileNameWithoutExtension returns name without extension', () {
      final status = StatusFile(
        filePath: '/path/to/file.jpg',
        fileName: 'file.jpg',
        extension: '.jpg',
        fileSize: 1024,
        lastModified: now,
        mediaType: MediaType.image,
      );

      expect(status.fileNameWithoutExtension, 'file');
    });

    test('equality works correctly', () {
      final a = StatusFile(
        filePath: '/path/a.jpg',
        fileName: 'a.jpg',
        extension: '.jpg',
        fileSize: 100,
        lastModified: now,
        mediaType: MediaType.image,
      );

      final b = StatusFile(
        filePath: '/path/a.jpg',
        fileName: 'a.jpg',
        extension: '.jpg',
        fileSize: 100,
        lastModified: now,
        mediaType: MediaType.image,
      );

      expect(a, equals(b));
    });

    test('inequality works correctly', () {
      final a = StatusFile(
        filePath: '/path/a.jpg',
        fileName: 'a.jpg',
        extension: '.jpg',
        fileSize: 100,
        lastModified: now,
        mediaType: MediaType.image,
      );

      final b = StatusFile(
        filePath: '/path/b.jpg',
        fileName: 'b.jpg',
        extension: '.jpg',
        fileSize: 200,
        lastModified: now,
        mediaType: MediaType.image,
      );

      expect(a, isNot(equals(b)));
    });
  });
}
