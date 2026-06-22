import 'package:flutter_test/flutter_test.dart';
import 'package:statuses/utils/file_utils.dart';

void main() {
  group('FileUtils.detectMediaType', () {
    test('returns image for .jpg', () {
      expect(FileUtils.detectMediaType('.jpg'), MediaType.image);
    });

    test('returns image for .png', () {
      expect(FileUtils.detectMediaType('.png'), MediaType.image);
    });

    test('returns video for .mp4', () {
      expect(FileUtils.detectMediaType('.mp4'), MediaType.video);
    });

    test('returns video for .3gp', () {
      expect(FileUtils.detectMediaType('.3gp'), MediaType.video);
    });

    test('is case insensitive', () {
      expect(FileUtils.detectMediaType('.JPG'), MediaType.image);
      expect(FileUtils.detectMediaType('.MP4'), MediaType.video);
    });

    test('returns unknown for unsupported extension', () {
      expect(FileUtils.detectMediaType('.xyz'), MediaType.unknown);
    });
  });

  group('FileUtils.formatFileSize', () {
    test('formats bytes', () {
      expect(FileUtils.formatFileSize(500), '500 B');
    });

    test('formats KB', () {
      expect(FileUtils.formatFileSize(2048), '2.0 KB');
    });

    test('formats MB', () {
      expect(FileUtils.formatFileSize(5_242_880), '5.0 MB');
    });

    test('formats GB', () {
      expect(FileUtils.formatFileSize(3_221_225_472), '3.0 GB');
    });

    test('handles zero', () {
      expect(FileUtils.formatFileSize(0), '0 B');
    });
  });

  group('FileUtils.mimeTypeFromExtension', () {
    test('returns correct MIME for jpg', () {
      expect(FileUtils.mimeTypeFromExtension('.jpg'), 'image/jpeg');
    });

    test('returns correct MIME for mp4', () {
      expect(FileUtils.mimeTypeFromExtension('.mp4'), 'video/mp4');
    });

    test('returns octet-stream for unknown', () {
      expect(FileUtils.mimeTypeFromExtension('.xyz'), 'application/octet-stream');
    });
  });
}
