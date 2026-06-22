class AppConstants {
  AppConstants._();

  static const String appName = 'Statuses';

  static const List<String> whatsappStatusPaths = [
    '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses',
    '/storage/emulated/0/WhatsApp/Media/.Statuses',
  ];

  static const String savedDirName = 'Statuses';

  static const Duration pollInterval = Duration(seconds: 15);

  static const int gridCrossAxisCount = 3;
  static const int gridCrossAxisCountLandscape = 5;

  static const double thumbnailSize = 120.0;
  static const double listThumbnailSize = 48.0;
}
