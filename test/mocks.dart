import 'dart:io';

import 'package:statuses/data/models/status_file.dart';
import 'package:statuses/data/repositories/status_repository.dart';
import 'package:statuses/utils/file_utils.dart';

class FakeStatusRepository extends StatusRepository {
  List<StatusFile> _statuses = [];

  FakeStatusRepository() : super();

  void setStatuses(List<StatusFile> statuses) {
    _statuses = statuses;
  }

  @override
  Future<List<StatusFile>> loadStatuses() async => _statuses;

  @override
  Future<bool> needsSafFallback() async => false;

  @override
  Future<bool> hasStatusDirectory() async => true;

  @override
  Future<Uri?> requestSafPermission() async => null;

  @override
  Future<void> copyToDirectory(StatusFile status, String destDir) async {}
}

class FakeDownloadService {
  final List<StatusFile> _saved = [];

  Future<String> getDownloadDirectory() async => Directory.systemTemp.path;
  Future<String> downloadStatus(StatusFile status) async {
    _saved.add(status);
    return '${Directory.systemTemp.path}/${status.fileName}';
  }

  Future<List<StatusFile>> getSavedStatuses() async => List.from(_saved);
  Future<String> getStorageUsage() async => '0 B';
  Future<void> shareStatus(StatusFile status) async {}
}

class FakeShareService {
  Future<void> repostToWhatsApp(StatusFile status) async {}
}

class FakeNotificationService {
  bool initialized = false;
  bool permissionGranted = true;

  Future<void> initialize() async {
    initialized = true;
  }

  Future<bool> requestPermission() async => permissionGranted;
  Future<void> showGroupedNotification(int count, String body) async {}
  Future<void> cancelAll() async {}
}

StatusFile createTestStatus({
  String filePath = '/status/file.jpg',
  String fileName = 'file.jpg',
  String extension = '.jpg',
  int fileSize = 1024,
  MediaType mediaType = MediaType.image,
}) {
  return StatusFile(
    filePath: filePath,
    fileName: fileName,
    extension: extension,
    fileSize: fileSize,
    lastModified: DateTime.now(),
    mediaType: mediaType,
  );
}
