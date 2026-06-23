import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:statuses/providers/notification_notifier.dart';
import 'package:statuses/providers/status_notifier.dart';
import 'mocks.dart';

void main() {
  late NotificationNotifier notifier;
  late StatusNotifier statusNotifier;
  late FakeStatusRepository fakeRepo;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    fakeRepo = FakeStatusRepository();
    statusNotifier = StatusNotifier(fakeRepo);
    notifier = NotificationNotifier(statusNotifier);
  });

  group('NotificationNotifier', () {
    test('initial state is disabled', () {
      expect(notifier.isEnabled, false);
    });
  });
}
