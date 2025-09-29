// ABOUTME: Service for managing offline video availability and connectivity-aware playback
// ABOUTME: Provides intelligent fallbacks and user feedback for offline/online video access

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:openvine/services/video_cache_manager.dart';
import 'package:openvine/utils/unified_logger.dart';
import 'package:openvine/models/video_event.dart';

class OfflineVideoService {
  static final OfflineVideoService _instance = OfflineVideoService._internal();
  factory OfflineVideoService() => _instance;
  OfflineVideoService._internal();

  final Connectivity _connectivity = Connectivity();
  final VideoCacheManager _videoCache = openVineVideoCache;

  /// Check if device is currently online
  Future<bool> isOnline() async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();

      final online = !connectivityResult.contains(ConnectivityResult.none);

      Log.debug('🌐 Connectivity status: ${online ? 'Online' : 'Offline'}',
          name: 'OfflineVideoService', category: LogCategory.system);

      return online;
    } catch (error) {
      Log.warning('⚠️ Error checking connectivity, assuming online: $error',
          name: 'OfflineVideoService', category: LogCategory.system);
      return true; // Default to online if check fails
    }
  }

  /// Check what videos are available offline from a list
  Future<List<VideoEvent>> getAvailableOfflineVideos(List<VideoEvent> videos) async {
    final availableVideos = <VideoEvent>[];

    for (final video in videos) {
      if (await _videoCache.isVideoCached(video.id)) {
        availableVideos.add(video);
      }
    }

    Log.info('📱 Found ${availableVideos.length}/${videos.length} videos available offline',
        name: 'OfflineVideoService', category: LogCategory.video);

    return availableVideos;
  }

  /// Get user-friendly status message
  Future<String> getStatusMessage() async {
    final isOnline = await this.isOnline();
    final cacheStats = await _videoCache.getCacheStats();

    if (isOnline) {
      return 'Online • ${cacheStats['totalFiles']} videos cached (${cacheStats['totalSizeMB']} MB)';
    } else {
      return 'Offline • ${cacheStats['totalFiles']} cached videos available';
    }
  }
}