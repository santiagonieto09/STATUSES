# Statuses

A Flutter Android app for viewing and managing WhatsApp Status media files stored locally on your device.

## Features

- Browse WhatsApp status media (images, videos, audio)
- Grid and list view modes with toggle
- Download statuses to your device
- Share statuses with other apps
- Video playback with play/pause controls
- Pinch-to-zoom for images
- Dark/light/system theme support with persistence
- Auto-refresh detects new statuses automatically
- Responsive layout (adapts to portrait/landscape)

## Permissions

The app requires storage access to read WhatsApp status files:

- **Android 13+ (API 33+):** `READ_MEDIA_IMAGES`, `READ_MEDIA_VIDEO`, `READ_MEDIA_AUDIO`
- **Android 11-12 (API 30-32):** `MANAGE_EXTERNAL_STORAGE`
- **Android 10 and below (API <30):** `READ_EXTERNAL_STORAGE`

All data remains on your device. Statuses does not collect, transmit, or modify any files.

## Build

```bash
flutter pub get
flutter build apk
```

For a release build:
```bash
flutter build apk --release
```

## Architecture

```
lib/
├── data/           # Models, repositories, services
├── providers/      # State management (ChangeNotifier + Provider)
├── ui/
│   ├── screens/    # App screens
│   ├── widgets/    # Reusable widgets
│   └── theme/      # Design system, light/dark themes
├── constants/      # App-wide constants
└── utils/          # Utilities (dates, file types)
```

## Tech Stack

- **Framework:** Flutter 3.27+
- **State Management:** Provider
- **Permissions:** permission_handler
- **Video:** video_player
- **Caching:** flutter_cache_manager
- **Persistence:** shared_preferences
- **Sharing:** share_plus

## Disclaimer

Statuses is an independent app. It is not affiliated with, endorsed by, or connected to WhatsApp or Meta Platforms, Inc. Statuses only reads files that WhatsApp has already stored on your device and does not modify or interfere with WhatsApp in any way.
