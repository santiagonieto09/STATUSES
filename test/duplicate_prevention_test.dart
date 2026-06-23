import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:statuses/utils/file_utils.dart';
import 'package:crypto/crypto.dart';

void main() {
  late Directory tempDir;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('dup_test_');
  });

  tearDown(() {
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  group('FileUtils.computeFileHash', () {
    test('returns consistent hash for same file', () async {
      final file = File('${tempDir.path}/test.jpg');
      await file.writeAsBytes([1, 2, 3, 4, 5]);

      final hash1 = await FileUtils.computeFileHash(file.path);
      final hash2 = await FileUtils.computeFileHash(file.path);

      expect(hash1, equals(hash2));
    });

    test('returns different hash for different files', () async {
      final fileA = File('${tempDir.path}/a.jpg');
      await fileA.writeAsBytes([1, 2, 3, 4, 5]);
      final fileB = File('${tempDir.path}/b.jpg');
      await fileB.writeAsBytes([5, 4, 3, 2, 1]);

      final hashA = await FileUtils.computeFileHash(fileA.path);
      final hashB = await FileUtils.computeFileHash(fileB.path);

      expect(hashA, isNot(equals(hashB)));
    });

    test('returns correct SHA-256 format', () async {
      final file = File('${tempDir.path}/test.jpg');
      final content = [1, 2, 3, 4, 5];
      await file.writeAsBytes(content);

      final hash = await FileUtils.computeFileHash(file.path);
      final expected = sha256.convert(content).toString();

      expect(hash, equals(expected));
    });

    test('handles empty file', () async {
      final file = File('${tempDir.path}/empty.jpg');
      await file.writeAsBytes([]);

      final hash = await FileUtils.computeFileHash(file.path);
      final expected = sha256.convert([]).toString();

      expect(hash, equals(expected));
    });
  });

  group('Duplicate prevention logic', () {
    test('same content files have same hash', () async {
      final file1 = File('${tempDir.path}/status1.jpg');
      final file2 = File('${tempDir.path}/status2.jpg');
      await Future.wait([
        file1.writeAsBytes([10, 20, 30, 40]),
        file2.writeAsBytes([10, 20, 30, 40]),
      ]);

      final hash1 = await FileUtils.computeFileHash(file1.path);
      final hash2 = await FileUtils.computeFileHash(file2.path);

      expect(hash1, equals(hash2));
    });

    test('different content files have different hashes', () async {
      final file1 = File('${tempDir.path}/status1.jpg');
      final file2 = File('${tempDir.path}/status2.jpg');
      await Future.wait([
        file1.writeAsBytes([10, 20, 30, 40]),
        file2.writeAsBytes([50, 60, 70, 80]),
      ]);

      final hash1 = await FileUtils.computeFileHash(file1.path);
      final hash2 = await FileUtils.computeFileHash(file2.path);

      expect(hash1, isNot(equals(hash2)));
    });

    test('partial hash for large files includes size divider', () async {
      final largeContent = List.filled(20 * 1024 * 1024, 65);
      final file = File('${tempDir.path}/large.mp4');
      await file.writeAsBytes(largeContent);

      final hash = await FileUtils.computeFileHash(file.path);

      expect(hash, contains('|'));
      final parts = hash.split('|');
      expect(parts.length, 2);
      expect(parts[1], '${largeContent.length}');
    });
  });
}
