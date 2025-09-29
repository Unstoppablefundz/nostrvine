// ABOUTME: Pure explore video feed using revolutionary Riverpod architecture
// ABOUTME: Shows curated videos with same performance as main feed without VideoManager dependencies

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openvine/models/curation_set.dart';
import 'package:openvine/models/video_event.dart';
import 'package:openvine/widgets/pure/video_feed_screen.dart';
import 'package:openvine/utils/unified_logger.dart';

/// Pure explore video feed screen using revolutionary single-controller Riverpod architecture
class ExploreVideoFeedScreenPure extends ConsumerWidget {
  const ExploreVideoFeedScreenPure({
    super.key,
    required this.curationSetType,
    required this.title,
    this.startingVideo,
    this.startingIndex = 0,
  });

  final CurationSetType curationSetType;
  final String title;
  final VideoEvent? startingVideo;
  final int startingIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Log.info('🎯 ExploreVideoFeedScreenPure: Building $title feed',
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
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        key: Key('explore-feed-${curationSetType.name}'),
        child: VideoFeedScreen(),
      ),
    );
  }
}