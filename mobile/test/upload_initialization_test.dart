// ABOUTME: Test for upload initialization issue to reproduce the "Failed to start upload" error
// ABOUTME: Uses TDD approach to identify and fix the root cause

import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:openvine/services/upload_manager.dart';
import 'package:openvine/services/direct_upload_service.dart';
import 'package:openvine/services/auth_service.dart';
import 'package:openvine/models/pending_upload.dart';
import 'package:openvine/services/circuit_breaker_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  group('Upload Initialization Issue', () {
    late UploadManager uploadManager;
    late DirectUploadService uploadService;
    late AuthService authService;
    
    setUpAll(() async {
      // Initialize Hive for testing
      final tempDir = Directory.systemTemp.createTempSync();
      Hive.init(tempDir.path);
      
      // Register adapters if not already registered
      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(UploadStatusAdapter());
      }
      if (!Hive.isAdapterRegistered(2)) {
        Hive.registerAdapter(PendingUploadAdapter());
      }
    });
    
    setUp(() async {
      // Create real services
      authService = AuthService();
      uploadService = DirectUploadService(authService: authService);
      uploadManager = UploadManager(uploadService: uploadService);
      
      // Initialize upload manager
      await uploadManager.initialize();
    });
    
    tearDown(() async {
      uploadManager.dispose();
      await Hive.deleteFromDisk();
    });
    
    test('should fail to start upload when video file does not exist', () async {
      // Arrange
      final nonExistentFile = File('/path/that/does/not/exist/video.mp4');
      const userPubkey = 'test_pubkey_123';
      
      // Act & Assert
      expect(
        () async => await uploadManager.startUpload(
          videoFile: nonExistentFile,
          nostrPubkey: userPubkey,
          title: 'Test Video',
        ),
        throwsA(isA<Exception>()),
      );
    });
    
    test('should fail gracefully when auth service has no pubkey', () async {
      // Arrange - create a temp video file
      final tempFile = File('${Directory.systemTemp.path}/test_video.mp4');
      await tempFile.writeAsBytes([1, 2, 3, 4, 5]); // Create dummy file
      
      // Act & Assert
      try {
        final upload = await uploadManager.startUpload(
          videoFile: tempFile,
          nostrPubkey: 'anonymous', // Using anonymous when no auth
          title: 'Test Video',
        );
        
        // Should create upload but mark as pending
        expect(upload, isNotNull);
        expect(upload.status, equals(UploadStatus.pending));
      } finally {
        // Cleanup
        if (tempFile.existsSync()) {
          await tempFile.delete();
        }
      }
    });
    
    test('should handle DirectUploadService errors properly', () async {
      // Arrange - create a temp video file
      final tempFile = File('${Directory.systemTemp.path}/test_video.mp4');
      await tempFile.writeAsBytes([1, 2, 3, 4, 5]); // Create dummy file
      
      // Create a manager with a misconfigured service
      final brokenService = DirectUploadService(authService: AuthService());
      final brokenManager = UploadManager(
        uploadService: brokenService,
        circuitBreaker: VideoCircuitBreaker(),
      );
      await brokenManager.initialize();
      
      // Act
      try {
        final upload = await brokenManager.startUpload(
          videoFile: tempFile,
          nostrPubkey: 'test_pubkey',
          title: 'Test Video',
        );
        
        // Should create the upload record even if upload process fails
        expect(upload, isNotNull);
        expect(upload.localVideoPath, equals(tempFile.path));
        
        // Wait a bit for the upload to attempt
        await Future.delayed(Duration(milliseconds: 100));
        
        // Check if upload is in failed or retrying state
        final updatedUpload = brokenManager.getUpload(upload.id);
        expect(updatedUpload, isNotNull);
        // Upload might be retrying or failed
        expect(
          [UploadStatus.retrying, UploadStatus.failed, UploadStatus.uploading]
              .contains(updatedUpload!.status),
          isTrue,
        );
      } finally {
        // Cleanup
        brokenManager.dispose();
        if (tempFile.existsSync()) {
          await tempFile.delete();
        }
      }
    });
  });
}