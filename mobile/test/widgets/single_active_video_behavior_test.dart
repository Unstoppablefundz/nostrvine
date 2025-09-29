import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openvine/models/video_event.dart';
import 'package:openvine/providers/individual_video_providers.dart';
import 'package:openvine/widgets/video_feed_item.dart';

void main() {
  group('Single active video behavior', () {
    late VideoEvent videoA;
    late VideoEvent videoB;

    setUp(() {
      final now = DateTime.now();
      videoA = VideoEvent(
        id: 'vid_A',
        pubkey: 'pk_A',
        content: 'Video A',
        videoUrl: 'https://example.com/a.mp4',
        title: 'A',
        createdAt: now.millisecondsSinceEpoch ~/ 1000,
        timestamp: now,
      );
      videoB = VideoEvent(
        id: 'vid_B',
        pubkey: 'pk_B',
        content: 'Video B',
        videoUrl: 'https://example.com/b.mp4',
        title: 'B',
        createdAt: now.millisecondsSinceEpoch ~/ 1000,
        timestamp: now,
      );
    });

    testWidgets('latest activated video wins, only one active', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Column(
              children: [
                SizedBox(height: 200, child: VideoFeedItem(video: videoA, index: 0)),
                SizedBox(height: 200, child: VideoFeedItem(video: videoB, index: 1)),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      final container = ProviderScope.containerOf(
        tester.element(find.byType(VideoFeedItem).first),
      );

      // Activate A
      container.read(activeVideoProvider.notifier).setActiveVideo(videoA.id);
      await tester.pump();
      expect(container.read(activeVideoProvider), equals(videoA.id));
      expect(container.read(isVideoActiveProvider(videoA.id)), isTrue);
      expect(container.read(isVideoActiveProvider(videoB.id)), isFalse);

      // Activate B; ensures A is no longer active
      container.read(activeVideoProvider.notifier).setActiveVideo(videoB.id);
      await tester.pump();
      expect(container.read(activeVideoProvider), equals(videoB.id));
      expect(container.read(isVideoActiveProvider(videoB.id)), isTrue);
      expect(container.read(isVideoActiveProvider(videoA.id)), isFalse);
    });
  });
}

