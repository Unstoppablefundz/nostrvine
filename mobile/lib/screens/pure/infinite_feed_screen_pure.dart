// ABOUTME: Pure infinite scroll video feed using revolutionary Riverpod architecture
// ABOUTME: Continuously loads videos without VideoManager dependencies or legacy services

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openvine/models/feed_type.dart';
import 'package:openvine/providers/video_events_providers.dart';
import 'package:openvine/widgets/pure/video_feed_screen.dart';
import 'package:openvine/utils/unified_logger.dart';

/// Pure infinite feed screen using revolutionary single-controller Riverpod architecture
class InfiniteFeedScreenPure extends ConsumerWidget {
  const InfiniteFeedScreenPure({
    super.key,
    required this.feedType,
    this.startingIndex = 0,
  });

  final FeedType feedType;
  final int startingIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Log.info('🌊 InfiniteFeedScreenPure: Building ${feedType.displayName} feed',
        category: LogCategory.video);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          key: const Key('back-button'),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          feedType.displayName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              // Refresh by invalidating the video events provider
              ref.invalidate(videoEventsProvider);
              Log.info('🌊 InfiniteFeedScreenPure: Refreshing ${feedType.displayName} feed',
                  category: LogCategory.video);
            },
          ),
        ],
      ),
      body: Container(
        key: Key('infinite-feed-${feedType.name}'),
        child: VideoFeedScreen(),
      ),
    );
  }
}