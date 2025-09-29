import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openvine/providers/individual_video_providers.dart';

void main() {
  group('PrewarmManager', () {
    test('caps prewarmed ids to specified cap', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(prewarmManagerProvider.notifier);

      // Provide more ids than the cap
      final ids = List.generate(10, (i) => 'v$i');
      notifier.setPrewarmed(ids, cap: 3);

      final state = container.read(prewarmManagerProvider);
      expect(state.length, 3);

      // Update with a different set
      notifier.setPrewarmed(['a', 'b', 'c', 'd'], cap: 2);
      final state2 = container.read(prewarmManagerProvider);
      expect(state2, containsAll(['a', 'b']));
      expect(state2.length, 2);
    });
  });
}

