// ABOUTME: Integration tests for ProofMode session lifecycle during video recording
// ABOUTME: Tests ProofModeSessionService integration with VineRecordingController

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:openvine/services/proofmode_session_service.dart' as proofmode;
import 'package:openvine/services/vine_recording_controller.dart';

// Generate mocks
@GenerateMocks([proofmode.ProofModeSessionService])
import 'proofmode_recording_integration_test.mocks.dart';

void main() {
  group('ProofMode Recording Integration', () {
    late MockProofModeSessionService mockProofModeService;

    setUp(() {
      mockProofModeService = MockProofModeSessionService();
    });

    test('startRecording initiates ProofMode session on first segment', () async {
      // Arrange: Mock ProofMode service to return a session ID
      when(mockProofModeService.startSession())
          .thenAnswer((_) async => 'test-session-123');
      when(mockProofModeService.startRecordingSegment())
          .thenAnswer((_) async => {});

      // TODO: Create VineRecordingController with mockProofModeService
      // TODO: Call startRecording()

      // Assert: Verify ProofMode session was started
      verify(mockProofModeService.startSession()).called(1);
      verify(mockProofModeService.startRecordingSegment()).called(1);
    });

    test('stopRecording stops ProofMode segment', () async {
      // Arrange
      when(mockProofModeService.startSession())
          .thenAnswer((_) async => 'test-session-123');
      when(mockProofModeService.startRecordingSegment())
          .thenAnswer((_) async => {});
      when(mockProofModeService.stopRecordingSegment())
          .thenAnswer((_) async => {});

      // TODO: Create controller and start recording
      // TODO: Call stopRecording()

      // Assert: Verify segment was stopped
      verify(mockProofModeService.stopRecordingSegment()).called(1);
    });

    test('finishRecording returns video File and ProofManifest', () async {
      // Arrange: Mock a complete ProofMode session
      final now = DateTime.now();
      final mockManifest = proofmode.ProofManifest(
        sessionId: 'test-session-123',
        challengeNonce: 'challenge-nonce-123',
        vineSessionStart: now,
        vineSessionEnd: now.add(const Duration(seconds: 2)),
        segments: [
          proofmode.RecordingSegment(
            segmentId: 'segment-1',
            startTime: now,
            endTime: now.add(const Duration(seconds: 2)),
            frameHashes: ['hash1', 'hash2'],
          ),
        ],
        pauseProofs: [],
        interactions: [],
        finalVideoHash: 'final-video-hash-abc123',
      );

      when(mockProofModeService.startSession())
          .thenAnswer((_) async => 'test-session-123');
      when(mockProofModeService.finalizeSession(any))
          .thenAnswer((_) async => mockManifest);

      // TODO: Create controller, record, and finish
      // TODO: Call finishRecording()

      // Assert: Should return tuple (File?, ProofManifest?)
      // expect(result.$1, isNotNull); // File
      // expect(result.$2, equals(mockManifest)); // ProofManifest

      // Verify ProofMode session was finalized with video hash
      verify(mockProofModeService.finalizeSession(any)).called(1);
    });

    test('recording works without ProofMode service (null service)', () async {
      // Arrange: Create controller with null ProofMode service
      // TODO: Create VineRecordingController with proofModeService: null

      // Act: Record and finish without ProofMode
      // TODO: Call startRecording(), stopRecording(), finishRecording()

      // Assert: Should return video File but null ProofManifest
      // expect(result.$1, isNotNull); // File exists
      // expect(result.$2, isNull); // No ProofManifest

      // Verify no ProofMode methods were called (service is null)
      // Note: No verification needed since service is null
    });

    test('ProofMode session survives pause and resume cycle', () async {
      // Arrange
      when(mockProofModeService.startSession())
          .thenAnswer((_) async => 'test-session-123');
      when(mockProofModeService.startRecordingSegment())
          .thenAnswer((_) async => {});
      when(mockProofModeService.stopRecordingSegment())
          .thenAnswer((_) async => {});
      when(mockProofModeService.pauseRecording())
          .thenAnswer((_) async => {});
      when(mockProofModeService.resumeRecording())
          .thenAnswer((_) async => {});

      // TODO: Create controller and start first segment
      // TODO: Call startRecording() → stopRecording() → startRecording() again

      // Assert: Verify stop and start were called for pause/resume cycle
      verify(mockProofModeService.stopRecordingSegment()).called(1);
      verify(mockProofModeService.startRecordingSegment()).called(greaterThan(1));
    });

    test('ProofMode session handles recording errors gracefully', () async {
      // Arrange: Mock ProofMode service to throw error
      when(mockProofModeService.startSession())
          .thenThrow(Exception('ProofMode initialization failed'));

      // TODO: Create controller with failing ProofMode service
      // TODO: Call startRecording() and expect it to complete without throwing

      // Assert: Recording should continue even if ProofMode fails
      // expect(controller.state, equals(VineRecordingState.recording));
    });

    test('finishRecording calculates SHA256 hash of final video', () async {
      // Arrange
      when(mockProofModeService.startSession())
          .thenAnswer((_) async => 'test-session-123');
      when(mockProofModeService.finalizeSession(any))
          .thenAnswer((_) async {
        final testTime = DateTime.now();
        return proofmode.ProofManifest(
          sessionId: 'test-session-123',
          challengeNonce: 'test-nonce',
          vineSessionStart: testTime,
          vineSessionEnd: testTime.add(const Duration(seconds: 1)),
          segments: [],
          pauseProofs: [],
          interactions: [],
          finalVideoHash: 'captured-hash',
        );
      });

      // TODO: Create controller and record video
      // TODO: Call finishRecording()

      // Assert: Verify finalizeSession was called with a non-empty videoHash
      final captured = verify(mockProofModeService.finalizeSession(
        captureAny,
      )).captured;

      expect(captured.length, equals(1));
      expect(captured[0], isNotNull);
      expect(captured[0], isNotEmpty);
      expect(captured[0], matches(RegExp(r'^[a-f0-9]{64}$'))); // SHA256 hex format
    });
  });
}
