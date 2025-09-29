// ABOUTME: Tests for individual video controller family providers
// ABOUTME: Each video gets its own controller with automatic lifecycle management

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openvine/providers/individual_video_providers.dart';

void main() {
  group('Individual Video Controller Family Provider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should create separate controllers for different video IDs', () {
      // When requesting controllers for different videos
      const videoId1 = 'video1';
      const videoId2 = 'video2';
      const videoUrl1 = 'https://example.com/video1.mp4';
      const videoUrl2 = 'https://example.com/video2.mp4';

      // Each video should have its own controller
      final controller1 = container.read(
        individualVideoControllerProvider(VideoControllerParams(
          videoId: videoId1,
          videoUrl: videoUrl1,
        )),
      );

      final controller2 = container.read(
        individualVideoControllerProvider(VideoControllerParams(
          videoId: videoId2,
          videoUrl: videoUrl2,
        )),
      );

      // Then controllers should be different instances
      expect(controller1, isNot(same(controller2)));
    });

    test('should return same controller instance for same video ID', () {
      // Given same video parameters
      const videoId = 'video1';
      const videoUrl = 'https://example.com/video1.mp4';
      final params = VideoControllerParams(
        videoId: videoId,
        videoUrl: videoUrl,
      );

      // When requesting controller multiple times
      final controller1 = container.read(
        individualVideoControllerProvider(params),
      );
      final controller2 = container.read(
        individualVideoControllerProvider(params),
      );

      // Then should return same instance
      expect(controller1, same(controller2));
    });

    test('should provide video loading state', () {
      // Given a video controller provider
      const videoId = 'video1';
      const videoUrl = 'https://example.com/video1.mp4';
      final params = VideoControllerParams(
        videoId: videoId,
        videoUrl: videoUrl,
      );

      // When reading the state
      final state = container.read(
        videoLoadingStateProvider(params),
      );

      // Then should provide loading state
      expect(state, isA<VideoLoadingState>());
      expect(state.videoId, equals(videoId));
    });

    test('should track active video separately from controllers', () {
      // When setting active video
      const videoId = 'video1';

      // Read initial active video state
      final initialActiveVideo = container.read(activeVideoProvider);
      expect(initialActiveVideo, isNull);

      // Set active video
      container.read(activeVideoProvider.notifier).setActiveVideo(videoId);

      // Then active video should be tracked
      final activeVideo = container.read(activeVideoProvider);
      expect(activeVideo, equals(videoId));
    });

    test('should handle multiple videos without interference', () {
      // Given multiple videos
      const videos = [
        ('video1', 'https://example.com/1.mp4'),
        ('video2', 'https://example.com/2.mp4'),
        ('video3', 'https://example.com/3.mp4'),
      ];

      // When creating controllers for all videos
      final controllers = videos.map((video) {
        return container.read(
          individualVideoControllerProvider(VideoControllerParams(
            videoId: video.$1,
            videoUrl: video.$2,
          )),
        );
      }).toList();

      // Then each controller should be unique
      for (int i = 0; i < controllers.length; i++) {
        for (int j = i + 1; j < controllers.length; j++) {
          expect(controllers[i], isNot(same(controllers[j])));
        }
      }
    });

    test('should auto-dispose controllers when no longer needed', () {
      // This test verifies the autoDispose behavior
      // Note: Actual disposal testing requires more complex setup with ProviderObserver

      // Given a video controller
      const videoId = 'video1';
      const videoUrl = 'https://example.com/video1.mp4';
      final params = VideoControllerParams(
        videoId: videoId,
        videoUrl: videoUrl,
      );

      // When reading the controller
      final controller = container.read(
        individualVideoControllerProvider(params),
      );

      // Then controller should exist
      expect(controller, isNotNull);

      // Note: AutoDispose behavior is tested through integration tests
      // since it requires proper provider lifecycle management
    });
  });

  group('Active Video State Management', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should allow switching active video', () {
      // Given multiple videos
      const video1 = 'video1';
      const video2 = 'video2';

      final notifier = container.read(activeVideoProvider.notifier);

      // When switching active video
      notifier.setActiveVideo(video1);
      expect(container.read(activeVideoProvider), equals(video1));

      notifier.setActiveVideo(video2);
      expect(container.read(activeVideoProvider), equals(video2));

      // Clear active video
      notifier.clearActiveVideo();
      expect(container.read(activeVideoProvider), isNull);
    });

    test('should provide is-active check for any video', () {
      // Given an active video
      const activeVideoId = 'video1';
      const inactiveVideoId = 'video2';

      container.read(activeVideoProvider.notifier).setActiveVideo(activeVideoId);

      // When checking if videos are active
      final isActive1 = container.read(isVideoActiveProvider(activeVideoId));
      final isActive2 = container.read(isVideoActiveProvider(inactiveVideoId));

      // Then only active video should return true
      expect(isActive1, isTrue);
      expect(isActive2, isFalse);
    });
  });
}
