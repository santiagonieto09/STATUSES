import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:statuses/data/models/status_file.dart';
import 'package:statuses/utils/file_utils.dart';

class ShareService {
  static const _channel = MethodChannel('com.statuses.statuses/saf');

  Future<void> repostToWhatsApp(StatusFile status) async {
    try {
      final mimeType = FileUtils.mimeTypeFromExtension(status.extension);
      final success = await _channel.invokeMethod<bool>(
        'shareToWhatsAppStatus',
        {'filePath': status.filePath, 'mimeType': mimeType},
      );
      if (success == true) return;
    } catch (_) {}

    try {
      final whatsappUri = Uri.parse('whatsapp://send');
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri);
        return;
      }
    } catch (_) {}

    try {
      final waStatusUri = Uri.parse('https://wa.me/status');
      await launchUrl(waStatusUri, mode: LaunchMode.externalApplication);
    } catch (_) {
      await _shareViaIntent(status);
    }
  }

  Future<void> _shareViaIntent(StatusFile status) async {
    final file = XFile(
      status.filePath,
      mimeType: FileUtils.mimeTypeFromExtension(status.extension),
    );
    await SharePlus.instance.share(
      ShareParams(
        files: [file],
        text: 'Compartido desde Statuses',
      ),
    );
  }
}
