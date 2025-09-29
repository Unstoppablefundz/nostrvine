// ABOUTME: Pure Riverpod video feed screen widget using PageView for swipe navigation
// ABOUTME: Replaces legacy video feed implementations with reactive state management

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openvine/models/video_event.dart';
import 'package:openvine/providers/individual_video_providers.dart';
import 'package:openvine/providers/video_events_providers.dart';
import 'package:openvine/widgets/video_feed_item.dart';
import 'package:openvine/utils/unified_logger.dart';

/// Pure video feed screen using PageView for vertical scrolling
class VideoFeedScreen extends ConsumerWidget {
  const VideoFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videosAsync = ref.watch(videoEventsProvider);

    Log.debug('🎬 VideoFeedScreen: Building with videos async state',
        category: LogCategory.video);

    return videosAsync.when(
      data: (videos) => _buildVideoFeed(context, ref, videos),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading videos',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // Refresh videos
                ref.invalidate(videoEventsProvider);
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoFeed(BuildContext context, WidgetRef ref, List<VideoEvent> videos) {
    if (videos.isEmpty) {
      return const Center(
        child: Text('No videos available'),
      );
    }

    // Use active video provider position indirectly; start at 0 for pure view
    final currentIndex = 0;

    Log.debug('🎬 VideoFeedScreen: Building feed with ${videos.length} videos, current index: $currentIndex',
        category: LogCategory.video);

    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: videos.length,
      controller: PageController(
        initialPage: currentIndex >= 0 && currentIndex < videos.length ? currentIndex : 0,
      ),
      onPageChanged: (index) {
        Log.debug('🎬 VideoFeedScreen: Page changed to index $index',
            category: LogCategory.video);

        // Mark active video on page change
        if (index >= 0 && index < videos.length) {
          ref.read(activeVideoProvider.notifier).setActiveVideo(videos[index].id);
        }
      },
      itemBuilder: (context, index) {
        if (index >= videos.length) return const SizedBox.shrink();

        return VideoFeedItem(
          video: videos[index],
          index: index,
        );
      },
    );
  }
}
