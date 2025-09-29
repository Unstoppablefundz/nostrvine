import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openvine/providers/individual_video_providers.dart';

void main() {
  group('ActiveVideoNotifier + isVideoActiveProvider', () {
    test('defaults to no active video', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final activeId = container.read(activeVideoProvider);
      expect(activeId, isNull);
    });

    test('setActiveVideo marks only that id as active', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Initially none active
      expect(container.read(isVideoActiveProvider('idA')), false);
      expect(container.read(isVideoActiveProvider('idB')), false);

      // Set active to idA
      container.read(activeVideoProvider.notifier).setActiveVideo('idA');
      expect(container.read(activeVideoProvider), 'idA');
      expect(container.read(isVideoActiveProvider('idA')), true);
      expect(container.read(isVideoActiveProvider('idB')), false);

      // Switch to idB
      container.read(activeVideoProvider.notifier).setActiveVideo('idB');
      expect(container.read(activeVideoProvider), 'idB');
      expect(container.read(isVideoActiveProvider('idA')), false);
      expect(container.read(isVideoActiveProvider('idB')), true);
    });

    test('clearActiveVideo resets to null', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(activeVideoProvider.notifier).setActiveVideo('idA');
      expect(container.read(activeVideoProvider), 'idA');

      container.read(activeVideoProvider.notifier).clearActiveVideo();
      expect(container.read(activeVideoProvider), isNull);
      expect(container.read(isVideoActiveProvider('idA')), false);
    });
  });
}
