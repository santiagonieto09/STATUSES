import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statuses/app.dart';
import 'package:statuses/data/repositories/status_repository.dart';
import 'package:statuses/providers/download_notifier.dart';
import 'package:statuses/providers/status_notifier.dart';
import 'package:statuses/providers/theme_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(
          create: (_) => StatusNotifier(StatusRepository()),
        ),
        ChangeNotifierProvider(create: (_) => DownloadNotifier()),
      ],
      child: const StatusesApp(),
    ),
  );
}
