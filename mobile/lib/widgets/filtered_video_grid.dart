// ABOUTME: Widget wrapper that filters out broken videos from display
// ABOUTME: Prevents showing videos that have been marked as non-functional

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openvine/models/video_event.dart';
import 'package:openvine/providers/app_providers.dart';
import 'package:openvine/utils/unified_logger.dart';

class FilteredVideoGrid extends ConsumerWidget {
  const FilteredVideoGrid({
    super.key,
    required this.videos,
    required this.itemBuilder,
    required this.gridDelegate,
    this.padding,
    this.emptyBuilder,
  });

  final List<VideoEvent> videos;
  final Widget Function(BuildContext context, VideoEvent video, int index) itemBuilder;
  final SliverGridDelegate gridDelegate;
  final EdgeInsets? padding;
  final Widget Function()? emptyBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brokenVideoTracker = ref.watch(brokenVideoTrackerProvider);

    return brokenVideoTracker.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) {
        Log.warning('Failed to load broken video tracker, showing all videos: $error',
            name: 'FilteredVideoGrid');

        // Fallback: show all videos if broken video tracker fails to load
        return _buildGrid(context, videos);
      },
      data: (tracker) {
        // Filter out broken videos
        final filteredVideos = videos.where((video) => !tracker.isVideoBroken(video.id)).toList();

        final filteredCount = videos.length - filteredVideos.length;
        if (filteredCount > 0) {
          Log.debug('🚫 FilteredVideoGrid: Filtered out $filteredCount broken videos',
              name: 'FilteredVideoGrid');
        }

        if (filteredVideos.isEmpty && emptyBuilder != null) {
          return emptyBuilder!();
        }

        return _buildGrid(context, filteredVideos);
      },
    );
  }

  Widget _buildGrid(BuildContext context, List<VideoEvent> videosToShow) {
    if (videosToShow.isEmpty && emptyBuilder != null) {
      return emptyBuilder!();
    }

    return GridView.builder(
      padding: padding ?? const EdgeInsets.all(12),
      gridDelegate: gridDelegate,
      itemCount: videosToShow.length,
      itemBuilder: (context, index) {
        final video = videosToShow[index];
        return itemBuilder(context, video, index);
      },
    );
  }
}

/// Extension to easily filter video lists
extension VideoEventListFiltering on List<VideoEvent> {
  /// Filter out broken videos using the broken video tracker
  Future<List<VideoEvent>> filterBrokenVideos(WidgetRef ref) async {
    try {
      final tracker = await ref.read(brokenVideoTrackerProvider.future);
      final filtered = where((video) => !tracker.isVideoBroken(video.id)).toList();

      final filteredCount = length - filtered.length;
      if (filteredCount > 0) {
        Log.debug('🚫 Filtered out $filteredCount broken videos', name: 'VideoEventListFiltering');
      }

      return filtered;
    } catch (e) {
      Log.warning('Failed to filter broken videos, returning all: $e', name: 'VideoEventListFiltering');
      return this; // Return original list if filtering fails
    }
  }
}