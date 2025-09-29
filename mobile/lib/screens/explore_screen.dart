// ABOUTME: Explore screen with proper Vine theme and video grid functionality
// ABOUTME: Pure Riverpod architecture for video discovery with grid/feed modes

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openvine/models/video_event.dart';
import 'package:openvine/providers/individual_video_providers.dart';
import 'package:openvine/providers/video_events_providers.dart';
import 'package:openvine/screens/pure/explore_video_screen_pure.dart';
import 'package:openvine/theme/vine_theme.dart';
import 'package:openvine/utils/unified_logger.dart';
import 'package:openvine/widgets/video_thumbnail_widget.dart';

/// Pure ExploreScreen using revolutionary Riverpod architecture
class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isInFeedMode = false;
  List<VideoEvent>? _feedVideos;
  int _feedStartIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1); // Start on Popular Now
    _tabController.addListener(_onTabChanged);

    Log.info('🎯 ExploreScreenPure: Initialized with revolutionary architecture',
        category: LogCategory.video);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();

    Log.info('🎯 ExploreScreenPure: Disposed cleanly',
        category: LogCategory.video);
  }

  void _onTabChanged() {
    if (!mounted) return;

    Log.debug('🎯 ExploreScreenPure: Switched to tab ${_tabController.index}',
        category: LogCategory.video);

    // When in feed mode, update feed videos based on current tab
    if (_isInFeedMode) {
      _updateFeedForCurrentTab();
    }
  }

  void _updateFeedForCurrentTab() {
    if (!_isInFeedMode) return;

    final videoEventsAsync = ref.read(videoEventsProvider);
    videoEventsAsync.whenData((videos) {
      List<VideoEvent> tabVideos;
      switch (_tabController.index) {
        case 0: // Popular Now
          tabVideos = videos;
          break;
        case 1: // Trending
          tabVideos = videos.reversed.toList();
          break;
        case 2: // Editor's Pick
          tabVideos = []; // Empty for now
          break;
        default:
          tabVideos = videos;
      }

      if (tabVideos.isNotEmpty) {
        setState(() {
          _feedVideos = tabVideos;
          _feedStartIndex = 0; // Start from beginning when switching tabs
        });

        // Set new active video
        ref.read(activeVideoProvider.notifier).setActiveVideo(tabVideos[0].id);

        Log.info('🎯 Updated feed for tab ${_tabController.index} with ${tabVideos.length} videos',
            category: LogCategory.video);
      }
    });
  }

  void _enterFeedMode(List<VideoEvent> videos, int startIndex) {
    if (!mounted) return;

    setState(() {
      _isInFeedMode = true;
      _feedVideos = videos;
      _feedStartIndex = startIndex;
    });

    // Set active video; feed screen manages playback based on visibility
    if (startIndex >= 0 && startIndex < videos.length) {
      ref.read(activeVideoProvider.notifier).setActiveVideo(videos[startIndex].id);
    }

    Log.info('🎯 ExploreScreenPure: Entered feed mode at index $startIndex',
        category: LogCategory.video);
  }

  void _exitFeedMode() {
    if (!mounted) return;

    setState(() {
      _isInFeedMode = false;
      _feedVideos = null;
    });

    // Clear active video on exit
    ref.read(activeVideoProvider.notifier).clearActiveVideo();

    Log.info('🎯 ExploreScreenPure: Exited feed mode',
        category: LogCategory.video);
  }

  @override
  Widget build(BuildContext context) {
    if (_isInFeedMode) {
      return _buildFeedMode();
    }

    return Scaffold(
      backgroundColor: VineTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: VineTheme.vineGreen,
        title: Text(
          'Explore',
          style: TextStyle(
            color: VineTheme.whiteText,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 1,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: VineTheme.whiteText,
          indicatorWeight: 3,
          labelColor: VineTheme.whiteText,
          unselectedLabelColor: VineTheme.whiteText.withValues(alpha: 0.7),
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          tabs: const [
            Tab(text: 'Popular Now'),
            Tab(text: 'Trending'),
            Tab(text: "Editor's Pick"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPopularNowTab(),
          _buildTrendingTab(),
          _buildEditorsPickTab(),
        ],
      ),
    );
  }

  Widget _buildFeedMode() {
    final videos = _feedVideos ?? const <VideoEvent>[];
    return Scaffold(
      backgroundColor: VineTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: VineTheme.vineGreen,
        leading: IconButton(
          key: const Key('back-button'),
          icon: const Icon(Icons.arrow_back, color: VineTheme.whiteText),
          onPressed: _exitFeedMode,
        ),
        title: Text(
          'Explore',
          style: TextStyle(
            color: VineTheme.whiteText,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 1,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: VineTheme.whiteText,
          indicatorWeight: 3,
          labelColor: VineTheme.whiteText,
          unselectedLabelColor: VineTheme.whiteText.withValues(alpha: 0.7),
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          tabs: const [
            Tab(text: 'Popular Now'),
            Tab(text: 'Trending'),
            Tab(text: "Editor's Pick"),
          ],
        ),
      ),
      body: ExploreVideoScreenPure(
        startingVideo: videos[_feedStartIndex],
        videoList: videos,
        contextTitle: 'Videos',
        startingIndex: _feedStartIndex,
      ),
    );
  }

  Widget _buildEditorsPickTab() {
    return Container(
      key: const Key('editors-pick-content'),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, size: 64, color: VineTheme.secondaryText),
            const SizedBox(height: 16),
            Text(
              "Editor's Pick",
              style: TextStyle(
                color: VineTheme.primaryText,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Curated content coming soon',
              style: TextStyle(
                color: VineTheme.secondaryText,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularNowTab() {
    // Watch video events from our pure provider
    final videoEventsAsync = ref.watch(videoEventsProvider);

    return videoEventsAsync.when(
      loading: () => Center(
        child: CircularProgressIndicator(color: VineTheme.vineGreen),
      ),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 64, color: VineTheme.likeRed),
            const SizedBox(height: 16),
            Text(
              'Failed to load videos',
              style: TextStyle(color: VineTheme.likeRed, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              '$error',
              style: TextStyle(color: VineTheme.secondaryText, fontSize: 12),
            ),
          ],
        ),
      ),
      data: (videos) => _buildVideoGrid(videos, 'Popular Now'),
    );
  }

  Widget _buildTrendingTab() {
    // For now, use the same videos as Popular Now but with different sorting
    final videoEventsAsync = ref.watch(videoEventsProvider);

    return videoEventsAsync.when(
      loading: () => Center(
        child: CircularProgressIndicator(color: VineTheme.vineGreen),
      ),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 64, color: VineTheme.likeRed),
            const SizedBox(height: 16),
            Text(
              'Failed to load trending videos',
              style: TextStyle(color: VineTheme.likeRed, fontSize: 18),
            ),
          ],
        ),
      ),
      data: (videos) => _buildVideoGrid(videos.reversed.toList(), 'Trending'),
    );
  }

  Widget _buildVideoGrid(List<VideoEvent> videos, String tabName) {
    if (videos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.video_library, size: 64, color: VineTheme.secondaryText),
            const SizedBox(height: 16),
            Text(
              'No videos in $tabName',
              style: TextStyle(
                color: VineTheme.primaryText,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Check back later for new content',
              style: TextStyle(
                color: VineTheme.secondaryText,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return _buildVideoTile(video, index, videos);
      },
    );
  }

  Widget _buildVideoTile(VideoEvent video, int index, List<VideoEvent> videos) {
    return GestureDetector(
      onTap: () {
        Log.info('🎯 ExploreScreen: Tapped video tile at index $index',
            category: LogCategory.video);
        _enterFeedMode(videos, index);
      },
      child: Container(
        decoration: BoxDecoration(
          color: VineTheme.cardBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              // Video thumbnail with play overlay
              Expanded(
                flex: 4,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      color: VineTheme.cardBackground,
                      child: video.thumbnailUrl != null
                          ? VideoThumbnailWidget(
                              video: video,
                              width: double.infinity,
                              height: double.infinity,
                            )
                          : Container(
                              color: VineTheme.cardBackground,
                              child: Icon(
                                Icons.videocam,
                                size: 40,
                                color: VineTheme.secondaryText,
                              ),
                            ),
                    ),
                    // Play button overlay
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: VineTheme.darkOverlay,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.play_arrow,
                          size: 24,
                          color: VineTheme.whiteText,
                        ),
                      ),
                    ),
                    // Duration badge if available
                    if (video.duration != null)
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: VineTheme.darkOverlay,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${video.duration}s',
                            style: TextStyle(
                              color: VineTheme.whiteText,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Video info
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        video.title ??
                        (video.content.length > 25
                          ? '${video.content.substring(0, 25)}...'
                          : video.content),
                        style: TextStyle(
                          color: VineTheme.primaryText,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 12,
                            color: VineTheme.likeRed,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${video.originalLikes ?? 0}',
                            style: TextStyle(
                              color: VineTheme.secondaryText,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Public methods expected by main.dart
  void onScreenVisible() {
    // Handle screen becoming visible
    Log.debug('🎯 ExploreScreen became visible', category: LogCategory.video);
  }

  void onScreenHidden() {
    // Handle screen becoming hidden
    Log.debug('🎯 ExploreScreen became hidden', category: LogCategory.video);
  }

  bool get isInFeedMode => _isInFeedMode;

  void exitFeedMode() => _exitFeedMode();

  void showHashtagVideos(String hashtag) {
    Log.debug('🎯 ExploreScreen showing hashtag videos: $hashtag', category: LogCategory.video);
    // Implementation for hashtag filtering would go here
  }

  void playSpecificVideo(VideoEvent video, List<VideoEvent> videos, int index) {
    Log.debug('🎯 ExploreScreen playing specific video: ${video.id}', category: LogCategory.video);
    _enterFeedMode(videos, index);
  }
}
