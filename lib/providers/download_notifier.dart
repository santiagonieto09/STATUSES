import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:statuses/data/models/status_file.dart';
import 'package:statuses/data/services/download_service.dart';

class DownloadNotifier extends ChangeNotifier {
  static const String _autoSavePrefsKey = 'auto_save_enabled';

  final DownloadService _service = DownloadService();

  bool _isDownloading = false;
  String? _lastDownloadedPath;
  String? _error;

  List<StatusFile> _savedStatuses = [];
  Set<String> _cachedSavedFilePaths = {};
  bool _isSavedLoading = false;

  bool _autoSaveEnabled = false;
  String _autoSaveStorageInfo = '';

  bool get isDownloading => _isDownloading;
  String? get lastDownloadedPath => _lastDownloadedPath;
  String? get error => _error;

  List<StatusFile> get savedStatuses => _savedStatuses;
  int get savedCount => _savedStatuses.length;
  bool get isSavedLoading => _isSavedLoading;
  bool get hasSaved => _savedStatuses.isNotEmpty;
  Set<String> get savedFilePaths => _cachedSavedFilePaths;

  bool get autoSaveEnabled => _autoSaveEnabled;
  String get autoSaveStorageInfo => _autoSaveStorageInfo;

  DownloadNotifier() {
    _loadAutoSavePreference();
  }

  Future<void> _loadAutoSavePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _autoSaveEnabled = prefs.getBool(_autoSavePrefsKey) ?? false;
    await _updateStorageInfo();
    notifyListeners();
  }

  Future<void> toggleAutoSave(bool enabled) async {
    _autoSaveEnabled = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_autoSavePrefsKey, enabled);
    if (enabled) {
      await _loadSaved();
      await _updateStorageInfo();
    }
    notifyListeners();
  }

  Future<String> _updateStorageInfo() async {
    _autoSaveStorageInfo = await _service.getStorageUsage();
    return _autoSaveStorageInfo;
  }

  Future<bool> isStatusSaved(String filePath) async {
    final fileName = filePath.split('/').last;
    try {
      final dir = await _service.getDownloadDirectory();
      return await File('$dir/$fileName').exists();
    } catch (_) {
      return false;
    }
  }

  Future<void> autoSaveStatus(StatusFile status) async {
    if (!_autoSaveEnabled) return;
    try {
      await _service.downloadStatus(status);
      await _updateStorageInfo();
    } catch (e) {
      debugPrint('Auto-save falló para ${status.fileName}: $e');
    }
  }

  Future<void> downloadStatus(StatusFile status) async {
    _isDownloading = true;
    _error = null;
    notifyListeners();

    try {
      _lastDownloadedPath = await _service.downloadStatus(status);
      await _loadSaved();
      await _updateStorageInfo();
    } catch (e) {
      _error = 'Download failed: $e';
    }

    _isDownloading = false;
    notifyListeners();
  }

  Future<void> loadSavedStatuses() async {
    _isSavedLoading = true;
    notifyListeners();
    await _loadSaved();
    _isSavedLoading = false;
    notifyListeners();
  }

  Future<void> _loadSaved() async {
    try {
      _savedStatuses = await _service.getSavedStatuses();
      _cachedSavedFilePaths = _savedStatuses.map((s) => s.fileName).toSet();
    } catch (e) {
      _savedStatuses = [];
      _cachedSavedFilePaths = {};
    }
  }

  Future<void> shareStatus(StatusFile status) async {
    try {
      await _service.shareStatus(status);
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = 'Share failed: $e';
      notifyListeners();
    }
  }

  Future<String?> getDownloadDirectoryPath() async {
    try {
      return await _service.getDownloadDirectory();
    } catch (_) {
      return null;
    }
  }

  Future<void> deleteSavedStatuses(List<String> paths) async {
    for (final path in paths) {
      try {
        final file = File(path);
        if (await file.exists()) await file.delete();
      } catch (_) {
      }
    }
    await _loadSaved();
    await _updateStorageInfo();
    notifyListeners();
  }

  void clearState() {
    _lastDownloadedPath = null;
    _error = null;
    notifyListeners();
  }
}
