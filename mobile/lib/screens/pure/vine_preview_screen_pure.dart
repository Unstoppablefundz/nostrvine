// ABOUTME: Pure vine preview screen using revolutionary Riverpod architecture
// ABOUTME: Reviews recorded videos before publishing without VideoManager dependencies

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openvine/utils/unified_logger.dart';

/// Pure vine preview screen using revolutionary single-controller Riverpod architecture
class VinePreviewScreenPure extends ConsumerStatefulWidget {
  const VinePreviewScreenPure({
    super.key,
    required this.videoFile,
    required this.frameCount,
    required this.selectedApproach,
  });

  final File videoFile;
  final int frameCount;
  final String selectedApproach;

  @override
  ConsumerState<VinePreviewScreenPure> createState() => _VinePreviewScreenPureState();
}

class _VinePreviewScreenPureState extends ConsumerState<VinePreviewScreenPure> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _hashtagsController = TextEditingController();
  bool _isUploading = false;
  // bool _isExpiringPost = false; // Unused - commenting out
  // int _expirationHours = 24; // Unused - commenting out

  @override
  void initState() {
    super.initState();
    // Pre-populate with default hashtags
    _hashtagsController.text = 'openvine vine';

    Log.info('🎬 VinePreviewScreenPure: Initialized for file: ${widget.videoFile.path}',
        category: LogCategory.video);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _hashtagsController.dispose();
    super.dispose();

    Log.info('🎬 VinePreviewScreenPure: Disposed',
        category: LogCategory.video);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          key: const Key('back-button'),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Preview Video',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: _isUploading ? null : _publishVideo,
            child: _isUploading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : const Text(
                  'Publish',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Video preview section
          Expanded(
            flex: 3,
            child: Container(
              key: const Key('video-preview'),
              color: Colors.black,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 9 / 16, // Vertical video aspect ratio
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.play_circle_filled,
                            size: 64,
                            color: Colors.white54,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Video Preview',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Metadata input section
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title input
                    const Text(
                      'Title',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _titleController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Enter video title...',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        filled: true,
                        fillColor: Colors.grey[900],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Description input
                    const Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _descriptionController,
                      style: const TextStyle(color: Colors.white),
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Describe your video...',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        filled: true,
                        fillColor: Colors.grey[900],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Hashtags input
                    const Text(
                      'Hashtags',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _hashtagsController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Add hashtags...',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        filled: true,
                        fillColor: Colors.grey[900],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _publishVideo() async {
    setState(() {
      _isUploading = true;
    });

    try {
      Log.info('🎬 VinePreviewScreenPure: Publishing video: ${widget.videoFile.path}',
          category: LogCategory.video);

      // TODO: Implement video publishing with upload service
      // For now, simulate upload
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        // Navigate back to main feed after successful upload
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (e) {
      Log.error('🎬 VinePreviewScreenPure: Failed to publish video: $e',
          category: LogCategory.video);

      if (mounted) {
        setState(() {
          _isUploading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to publish video: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}