import 'package:flutter_test/flutter_test.dart';
import 'package:statuses/providers/status_notifier.dart';
import 'mocks.dart';

void main() {
  late StatusNotifier notifier;
  late FakeStatusRepository fakeRepo;

  setUp(() {
    fakeRepo = FakeStatusRepository();
    notifier = StatusNotifier(fakeRepo);
  });

  group('StatusNotifier', () {
    test('initial state', () {
      expect(notifier.statusCount, 0);
      expect(notifier.isLoading, false);
      expect(notifier.viewMode, ViewMode.grid);
      expect(notifier.filterMode, FilterMode.all);
      expect(notifier.errorMessage, isNull);
    });

    test('setFilterMode changes filter', () {
      notifier.setFilterMode(FilterMode.photo);
      expect(notifier.filterMode, FilterMode.photo);
      notifier.setFilterMode(FilterMode.video);
      expect(notifier.filterMode, FilterMode.video);
      notifier.setFilterMode(FilterMode.all);
      expect(notifier.filterMode, FilterMode.all);
    });

    test('filteredStatuses returns list for all mode', () {
      notifier.setFilterMode(FilterMode.all);
      expect(notifier.filteredStatuses, isA<List>());
    });
  });
}
