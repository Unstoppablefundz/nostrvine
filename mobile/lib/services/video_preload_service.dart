// ABOUTME: Service for intelligently preloading videos to improve playback performance
// ABOUTME: Manages background video initialization for smooth feed navigation

import 'dart:async';
import 'package:openvine/models/video_event.dart';
import 'package:openvine/utils/unified_logger.dart';
import 'package:openvine/services/video_cache_manager.dart';
import 'package:video_player/video_player.dart';

class VideoPreloadService {
  static final VideoPreloadService _instance = VideoPreloadService._internal();
  factory VideoPreloadService() => _instance;
  VideoPreloadService._internal();

  final Map<String, VideoPlayerController> _preloadedControllers = {};
  final Set<String> _preloadingVideos = {};
  static const int maxPreloadedVideos = 3;

  /// Preload videos in the background for smoother playback
  Future<void> preloadVideos(List<VideoEvent> videos, {int startIndex = 0, int preloadCount = 3}) async {
    if (videos.isEmpty) return;

    // Calculate range to preload around current index
    final endIndex = (startIndex + preloadCount).clamp(0, videos.length);
    final videosToPreload = videos.sublist(startIndex, endIndex);

    Log.info('🔄 Preloading ${videosToPreload.length} videos starting from index $startIndex',
        name: 'VideoPreloadService', category: LogCategory.video);

    // Clean up old preloaded controllers if we have too many
    await _cleanupExcessControllers();

    // Preload videos concurrently for better performance
    final preloadFutures = videosToPreload
        .where((video) => video.videoUrl != null && !_preloadedControllers.containsKey(video.id))
        .map((video) => _preloadSingleVideo(video));

    await Future.wait(preloadFutures, eagerError: false);
  }

  /// Preload a single video in the background
  Future<void> _preloadSingleVideo(VideoEvent video) async {
    if (video.videoUrl == null || _preloadingVideos.contains(video.id)) {
      return;
    }

    _preloadingVideos.add(video.id);

    try {
      Log.debug('🔄 Preloading video ${video.id.substring(0, 8)}...',
          name: 'VideoPreloadService', category: LogCategory.video);

      // For now, use network URL and cache in background
      final controller = VideoPlayerController.networkUrl(Uri.parse(video.videoUrl!));

      // Initialize with shorter timeout for background preloading
      await controller.initialize().timeout(
        const Duration(seconds: 8),
        onTimeout: () => throw TimeoutException('Preload timeout'),
      );

      controller.setLooping(true);

      _preloadedControllers[video.id] = controller;

      Log.info('✅ Video ${video.id.substring(0, 8)}... preloaded successfully (network)',
          name: 'VideoPreloadService', category: LogCategory.video);

      // Cache video in background for future use
      final videoCache = openVineVideoCache;
      videoCache.cacheVideo(video.videoUrl!, video.id).catchError((error) {
        Log.debug('⚠️ Background caching failed during preload: $error',
            name: 'VideoPreloadService', category: LogCategory.video);
        return null; // Return null on error
      });

    } catch (error) {
      Log.warning('⚠️ Failed to preload video ${video.id.substring(0, 8)}...: $error',
          name: 'VideoPreloadService', category: LogCategory.video);
    } finally {
      _preloadingVideos.remove(video.id);
    }
  }

  /// Get a preloaded controller if available
  VideoPlayerController? getPreloadedController(String videoId) {
    final controller = _preloadedControllers.remove(videoId);
    if (controller != null) {
      Log.info('🎯 Using preloaded controller for video ${videoId.substring(0, 8)}...',
          name: 'VideoPreloadService', category: LogCategory.video);
    }
    return controller;
  }

  /// Clean up excess preloaded controllers
  Future<void> _cleanupExcessControllers() async {
    if (_preloadedControllers.length <= maxPreloadedVideos) return;

    final controllersToRemove = _preloadedControllers.length - maxPreloadedVideos;
    final keysToRemove = _preloadedControllers.keys.take(controllersToRemove).toList();

    Log.debug('🧹 Cleaning up $controllersToRemove excess preloaded controllers',
        name: 'VideoPreloadService', category: LogCategory.video);

    for (final key in keysToRemove) {
      final controller = _preloadedControllers.remove(key);
      controller?.dispose();
    }
  }

  /// Clear all preloaded controllers
  void clearAll() {
    Log.info('🧹 Clearing all preloaded controllers (${_preloadedControllers.length})',
        name: 'VideoPreloadService', category: LogCategory.video);

    for (final controller in _preloadedControllers.values) {
      controller.dispose();
    }
    _preloadedControllers.clear();
    _preloadingVideos.clear();
  }

  /// Get current preload statistics
  Map<String, int> getStats() {
    return {
      'preloaded': _preloadedControllers.length,
      'preloading': _preloadingVideos.length,
      'maxPreload': maxPreloadedVideos,
    };
  }
}