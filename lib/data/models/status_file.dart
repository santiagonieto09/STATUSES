import 'package:statuses/utils/file_utils.dart';

class StatusFile {
  final String filePath;
  final String fileName;
  final String extension;
  final int fileSize;
  final DateTime lastModified;
  final MediaType mediaType;

  StatusFile({
    required this.filePath,
    required this.fileName,
    required this.extension,
    required this.fileSize,
    required this.lastModified,
    required this.mediaType,
  });

  String get fileNameWithoutExtension =>
      fileName.endsWith(extension)
          ? fileName.substring(0, fileName.length - extension.length)
          : fileName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatusFile &&
          runtimeType == other.runtimeType &&
          filePath == other.filePath &&
          lastModified == other.lastModified;

  @override
  int get hashCode => filePath.hashCode ^ lastModified.hashCode;
}
