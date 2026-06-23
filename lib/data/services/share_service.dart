import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:statuses/data/models/status_file.dart';

class ShareService {
  Future<void> repostToWhatsApp(StatusFile status) async {
    final whatsappUrl = Uri.parse('whatsapp://send?text=');
    try {
      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl);
      } else {
        await _shareViaIntent(status);
      }
    } catch (_) {
      await _shareViaIntent(status);
    }
  }

  Future<void> _shareViaIntent(StatusFile status) async {
    final file = XFile(
      status.filePath,
      mimeType: _mimeFromExtension(status.extension),
    );
    await SharePlus.instance.share(
      ShareParams(
        files: [file],
        text: 'Compartido desde Statuses',
      ),
    );
  }

  String _mimeFromExtension(String ext) {
    switch (ext.toLowerCase()) {
      case '.jpg':
      case '.jpeg':
        return 'image/jpeg';
      case '.png':
        return 'image/png';
      case '.gif':
        return 'image/gif';
      case '.webp':
        return 'image/webp';
      case '.mp4':
        return 'video/mp4';
      case '.3gp':
        return 'video/3gpp';
      default:
        return 'application/octet-stream';
    }
  }
}
