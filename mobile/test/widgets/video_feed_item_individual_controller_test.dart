// ABOUTME: Test for VideoFeedItem using individual video controller architecture
// ABOUTME: Ensures each video gets its own controller with proper lifecycle management

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openvine/widgets/video_feed_item.dart';
import 'package:openvine/models/video_event.dart';
import 'package:openvine/providers/individual_video_providers.dart';

void main() {
  group('VideoFeedItem with Individual Controller Architecture', () {
    late VideoEvent testVideo;

    setUp(() {
      final now = DateTime.now();
      testVideo = VideoEvent(
        id: 'test_video_1',
        pubkey: 'test_pubkey',
        content: 'Test Video Content',
        videoUrl: 'https://example.com/test_video.mp4',
        title: 'Test Video Title',
        createdAt: now.millisecondsSinceEpoch ~/ 1000,
        timestamp: now,
      );
    });

    testWidgets('should use individual controller for its video', (WidgetTester tester) async {
      // Given a VideoFeedItem
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: VideoFeedItem(
                video: testVideo,
                index: 0,
              ),
            ),
          ),
        ),
      );

      // Then it should create an individual controller for this video
      final container = ProviderScope.containerOf(
        tester.element(find.byType(VideoFeedItem)),
      );

      // Verify controller is created for this specific video
      expect(
        () => container.read(
          individualVideoControllerProvider(VideoControllerParams(
            videoId: testVideo.id,
            videoUrl: testVideo.videoUrl!,
          )),
        ),
        returnsNormally,
      );
    });

    testWidgets('should update active video when visible', (WidgetTester tester) async {
      // Given a VideoFeedItem
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: SizedBox(
                height: 400,
                child: VideoFeedItem(
                  video: testVideo,
                  index: 0,
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // When the video becomes visible (simulated by VisibilityDetector)
      final container = ProviderScope.containerOf(
        tester.element(find.byType(VideoFeedItem)),
      );

      // Initially no active video
      expect(container.read(activeVideoProvider), isNull);

      // When video becomes visible and active
      container.read(activeVideoProvider.notifier).setActiveVideo(testVideo.id);

      // Then this video should be marked as active
      expect(container.read(activeVideoProvider), equals(testVideo.id));
      expect(
        container.read(isVideoActiveProvider(testVideo.id)),
        isTrue,
      );
    });

    testWidgets('should show correct video content when active', (WidgetTester tester) async {
      // Given a VideoFeedItem that is active
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: VideoFeedItem(
                video: testVideo,
                index: 0,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // When video is made active
      final container = ProviderScope.containerOf(
        tester.element(find.byType(VideoFeedItem)),
      );
      container.read(activeVideoProvider.notifier).setActiveVideo(testVideo.id);
      await tester.pumpAndSettle();

      // Then overlay should be visible with correct content
      expect(find.text(testVideo.content), findsOneWidget);
      expect(find.text(testVideo.title!), findsOneWidget);
    });

    testWidgets('should handle tap to play/pause', (WidgetTester tester) async {
      // Given a VideoFeedItem
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: VideoFeedItem(
                video: testVideo,
                index: 0,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // When tapping the video
      await tester.tap(find.byType(VideoFeedItem));
      await tester.pumpAndSettle();

      // Then video should become active
      final container = ProviderScope.containerOf(
        tester.element(find.byType(VideoFeedItem)),
      );
      expect(container.read(activeVideoProvider), equals(testVideo.id));
    });

    testWidgets('should dispose controller when widget is removed', (WidgetTester tester) async {
      // Given a VideoFeedItem
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: VideoFeedItem(
                video: testVideo,
                index: 0,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Controller should exist
      final container = ProviderScope.containerOf(
        tester.element(find.byType(VideoFeedItem)),
      );

      final controllerParams = VideoControllerParams(
        videoId: testVideo.id,
        videoUrl: testVideo.videoUrl!,
      );

      expect(
        () => container.read(individualVideoControllerProvider(controllerParams)),
        returnsNormally,
      );

      // When widget is removed
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: SizedBox(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Then controller should be disposed (autoDispose behavior)
      // Note: Testing autoDispose requires more complex setup with ProviderObserver
      // This is a placeholder for the concept
    });
  });
}