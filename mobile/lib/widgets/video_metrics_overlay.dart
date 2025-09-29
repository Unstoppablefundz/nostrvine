// ABOUTME: Visual overlay to display video loading metrics directly in the app UI
// ABOUTME: Shows real-time performance data when videos load, bypassing console logging issues

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:openvine/services/video_loading_metrics.dart';

/// Visual overlay showing video loading metrics in development builds
class VideoMetricsOverlay extends StatefulWidget {
  final Widget child;

  const VideoMetricsOverlay({required this.child, super.key});

  @override
  State<VideoMetricsOverlay> createState() => _VideoMetricsOverlayState();
}

class _VideoMetricsOverlayState extends State<VideoMetricsOverlay> {
  final List<String> _recentMetrics = [];
  static const int maxMetrics = 5;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      // Hook into metrics system
      _setupMetricsListener();
    }
  }

  void _setupMetricsListener() {
    // We'll add this to the metrics service
    VideoLoadingMetrics.instance.onMetricsEvent = (String event) {
      if (mounted) {
        setState(() {
          _recentMetrics.insert(0, event);
          if (_recentMetrics.length > maxMetrics) {
            _recentMetrics.removeLast();
          }
        });
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (kDebugMode && _recentMetrics.isNotEmpty)
          Positioned(
            top: 50,
            left: 10,
            right: 10,
            child: Material(
              color: Colors.black.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.analytics, color: Colors.green, size: 16),
                        const SizedBox(width: 8),
                        const Text(
                          'Video Metrics Debug',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _recentMetrics.clear();
                            });
                          },
                          child: const Icon(Icons.clear, color: Colors.grey, size: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ..._recentMetrics.map((metric) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            metric,
                            style: const TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 11,
                              fontFamily: 'monospace',
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Static debug info widget
class VideoMetricsDebugInfo extends StatelessWidget {
  const VideoMetricsDebugInfo({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) return const SizedBox.shrink();

    return Positioned(
      bottom: 100,
      left: 10,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.purple.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '📊 Metrics Status',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              'Active Sessions: ${VideoLoadingMetrics.instance.activeSessions}',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            Text(
              'Total Started: ${VideoLoadingMetrics.metricsCount}',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}