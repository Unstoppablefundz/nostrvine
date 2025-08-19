// ABOUTME: Integration test that verifies pagination works with real relay server
// ABOUTME: Tests that we actually get new kind 32222 video events when scrolling

import 'package:flutter_test/flutter_test.dart';
import 'package:openvine/services/video_event_service.dart';
import 'package:openvine/services/nostr_service.dart';
import 'package:openvine/services/subscription_manager.dart';
import 'package:openvine/models/video_event.dart';
import 'package:openvine/utils/log.dart';

void main() {
  group('Real Relay Pagination Integration', () {
    late VideoEventService videoEventService;
    late NostrService nostrService;
    late SubscriptionManager subscriptionManager;

    setUpAll(() {
      // Enable debug logging to see what's happening
      Log.setLogLevel(LogLevel.debug);
    });

    setUp(() async {
      // Create real services
      nostrService = NostrService();
      subscriptionManager = SubscriptionManager(nostrService);
      videoEventService = VideoEventService(
        nostrService,
        subscriptionManager: subscriptionManager,
      );

      // Initialize and connect to real relay
      await nostrService.initialize();
      
      // Connect to OpenVine's relay
      await nostrService.connectToRelay('wss://relay3.openvine.co');
      
      // Wait for connection
      await Future.delayed(Duration(seconds: 2));
      
      expect(nostrService.isInitialized, isTrue);
      expect(nostrService.connectedRelayCount, greaterThan(0));
    });

    tearDown(() async {
      videoEventService.dispose();
      await nostrService.dispose();
    });

    test('should get real kind 32222 video events from relay3.openvine.co', () async {
      // Subscribe to discovery feed
      await videoEventService.subscribeToVideoFeed(
        subscriptionType: SubscriptionType.discovery,
        limit: 10,
      );
      
      // Wait for initial events
      await Future.delayed(Duration(seconds: 3));
      
      // Get initial videos
      final initialVideos = videoEventService.getVideos(SubscriptionType.discovery);
      print('\n📹 Initial videos loaded: ${initialVideos.length}');
      
      expect(initialVideos, isNotEmpty, reason: 'Should have loaded some initial videos');
      
      // Print first few videos to verify they're real
      for (int i = 0; i < initialVideos.length.take(3).length; i++) {
        final video = initialVideos[i];
        print('  Video ${i+1}: ${video.title ?? "Untitled"} - ${video.id.substring(0, 8)}... created at ${video.timestamp}');
        expect(video.videoUrl, isNotNull, reason: 'Real videos should have URLs');
      }
      
      // Store the IDs of initial videos
      final initialVideoIds = initialVideos.map((v) => v.id).toSet();
      final oldestInitialTimestamp = initialVideos.last.createdAt;
      
      print('\n🔄 Loading more events (pagination)...');
      print('  Oldest timestamp before load: ${DateTime.fromMillisecondsSinceEpoch(oldestInitialTimestamp * 1000)}');
      
      // Load more events - this should use pagination with 'until' parameter
      await videoEventService.loadMoreEvents(
        SubscriptionType.discovery,
        limit: 10,
      );
      
      // Wait for new events to arrive
      await Future.delayed(Duration(seconds: 3));
      
      // Get all videos after pagination
      final allVideos = videoEventService.getVideos(SubscriptionType.discovery);
      print('\n📹 Total videos after pagination: ${allVideos.length}');
      
      // Find new videos that weren't in the initial set
      final newVideos = allVideos.where((v) => !initialVideoIds.contains(v.id)).toList();
      print('  New videos loaded: ${newVideos.length}');
      
      // Verify we got new videos
      expect(newVideos, isNotEmpty, reason: 'Pagination should load NEW videos, not duplicates');
      
      // Verify the new videos are older than the initial ones
      for (final video in newVideos.take(3)) {
        print('  New video: ${video.title ?? "Untitled"} - created at ${video.timestamp}');
        expect(
          video.createdAt,
          lessThanOrEqualTo(oldestInitialTimestamp),
          reason: 'New videos should be older than or equal to the oldest initial video (reverse chronological pagination)',
        );
      }
      
      // Test pagination reset scenario
      print('\n🔄 Testing pagination reset scenario...');
      
      // Reset pagination state (simulating hasMore=false scenario)
      videoEventService.resetPaginationState(SubscriptionType.discovery);
      
      // Load more after reset - should still get older videos
      await videoEventService.loadMoreEvents(
        SubscriptionType.discovery,
        limit: 10,
      );
      
      await Future.delayed(Duration(seconds: 3));
      
      final videosAfterReset = videoEventService.getVideos(SubscriptionType.discovery);
      final newVideosAfterReset = videosAfterReset.where(
        (v) => !initialVideoIds.contains(v.id) && !newVideos.map((nv) => nv.id).contains(v.id)
      ).toList();
      
      print('\n📹 Videos after pagination reset:');
      print('  Total: ${videosAfterReset.length}');
      print('  New after reset: ${newVideosAfterReset.length}');
      
      if (newVideosAfterReset.isNotEmpty) {
        print('  Successfully loaded ${newVideosAfterReset.length} more videos after reset!');
        for (final video in newVideosAfterReset.take(3)) {
          print('    Video: ${video.title ?? "Untitled"} - ${video.timestamp}');
        }
      }
      
      // Final verification
      print('\n✅ Test Summary:');
      print('  Initial videos: ${initialVideos.length}');
      print('  Videos after first pagination: ${allVideos.length}');
      print('  Videos after reset and pagination: ${videosAfterReset.length}');
      print('  All videos are kind 32222: ${videosAfterReset.every((v) => v.kind == 32222)}');
    }, timeout: Timeout(Duration(seconds: 30)));

    test('should handle rapid pagination requests correctly', () async {
      // Subscribe to discovery feed
      await videoEventService.subscribeToVideoFeed(
        subscriptionType: SubscriptionType.discovery,
        limit: 5,
      );
      
      await Future.delayed(Duration(seconds: 2));
      
      final initialCount = videoEventService.getVideos(SubscriptionType.discovery).length;
      print('\n🚀 Testing rapid pagination - Initial videos: $initialCount');
      
      // Rapidly request more videos (simulating fast scrolling)
      for (int i = 0; i < 3; i++) {
        print('  Loading batch ${i + 1}...');
        await videoEventService.loadMoreEvents(
          SubscriptionType.discovery,
          limit: 5,
        );
        await Future.delayed(Duration(seconds: 2));
        
        final currentCount = videoEventService.getVideos(SubscriptionType.discovery).length;
        print('    Videos after batch ${i + 1}: $currentCount');
        
        expect(
          currentCount,
          greaterThan(initialCount),
          reason: 'Each pagination should increase video count',
        );
      }
      
      final finalVideos = videoEventService.getVideos(SubscriptionType.discovery);
      final uniqueIds = finalVideos.map((v) => v.id).toSet();
      
      print('\n✅ Rapid pagination results:');
      print('  Total videos: ${finalVideos.length}');
      print('  Unique videos: ${uniqueIds.length}');
      print('  No duplicates: ${finalVideos.length == uniqueIds.length}');
      
      expect(
        uniqueIds.length,
        equals(finalVideos.length),
        reason: 'Should not have duplicate videos',
      );
    }, timeout: Timeout(Duration(seconds: 30)));
  });
}