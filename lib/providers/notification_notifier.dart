import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:statuses/data/services/notification_service.dart';
import 'package:statuses/providers/status_notifier.dart';

class NotificationNotifier extends ChangeNotifier {
  static const String _prefsKey = 'notification_service_enabled';

  final StatusNotifier _statusNotifier;
  final NotificationService _service = NotificationService();
  Timer? _pollTimer;

  bool _isEnabled = false;
  int _lastKnownCount = 0;

  bool get isEnabled => _isEnabled;

  NotificationNotifier(this._statusNotifier) {
    _loadPreference();
  }

  Future<void> _loadPreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isEnabled = prefs.getBool(_prefsKey) ?? false;
    if (_isEnabled) {
      await _service.initialize();
      _startPolling();
    }
    notifyListeners();
  }

  Future<void> toggle() async {
    if (_isEnabled) {
      await disable();
    } else {
      await enable();
    }
  }

  Future<void> enable() async {
    await _service.initialize();

    final granted = await _service.requestPermission();
    if (!granted) {
      debugPrint('NotificationNotifier: permiso de notificaciones denegado');
      return;
    }

    _isEnabled = true;
    _lastKnownCount = _statusNotifier.statusCount;
    await _savePreference();
    _startPolling();
    notifyListeners();
  }

  Future<void> disable() async {
    _isEnabled = false;
    _stopPolling();
    await _service.cancelAll();
    await _savePreference();
    notifyListeners();
  }

  void _startPolling() {
    _stopPolling();
    _pollTimer = Timer.periodic(const Duration(seconds: 60), (_) {
      _checkForNewStatuses();
    });
  }

  void _stopPolling() {
    _pollTimer?.cancel();
    _pollTimer = null;
  }

  void _checkForNewStatuses() {
    final current = _statusNotifier.statusCount;
    if (current > _lastKnownCount) {
      final newCount = current - _lastKnownCount;
      final body = newCount == 1
          ? '1 nuevo estado disponible'
          : '$newCount nuevos estados disponibles';
      _service.showGroupedNotification(newCount, body);
    }
    _lastKnownCount = current;
  }

  Future<void> _savePreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKey, _isEnabled);
  }

  @override
  void dispose() {
    _stopPolling();
    super.dispose();
  }
}
