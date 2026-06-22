import 'dart:async';
import 'package:statuses/constants/app_constants.dart';
import 'package:statuses/data/repositories/status_repository.dart';

class FileWatcherService {
  final StatusRepository _repository;
  Timer? _timer;
  List<String> _lastSnapshot = [];
  final _controller = StreamController<List<String>>.broadcast();

  Stream<List<String>> get changes => _controller.stream;

  FileWatcherService(this._repository);

  void start() {
    _timer = Timer.periodic(AppConstants.pollInterval, (_) async {
      final statuses = await _repository.loadStatuses();
      final files = statuses
          .map((e) => '${e.filePath}|${e.lastModified.millisecondsSinceEpoch}')
          .toList();

      if (_hasChanged(files)) {
        _lastSnapshot = files;
        _controller.add(files);
      }
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  bool _hasChanged(List<String> current) {
    if (current.length != _lastSnapshot.length) return true;
    for (var i = 0; i < current.length; i++) {
      if (current[i] != _lastSnapshot[i]) return true;
    }
    return false;
  }

  void dispose() {
    stop();
    _controller.close();
  }
}
