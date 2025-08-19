// ABOUTME: Simple integration test to verify we get real kind 32222 events from relay
// ABOUTME: Tests the actual pagination fix against the real OpenVine relay

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_embedded_nostr_relay/flutter_embedded_nostr_relay.dart';
import 'package:nostr_sdk/nostr.dart' as nostr_sdk;

void main() {
  group('Real Relay Kind 32222 Events Test', () {
    test('should get real kind 32222 video events from relay3.openvine.co', () async {
      print('\n🚀 Starting real relay test...');
      
      // Create embedded relay
      final embeddedRelay = EmbeddedNostrRelay();
      
      // Start the embedded relay
      print('📡 Starting embedded relay...');
      await embeddedRelay.start();
      
      // Wait for it to be ready
      await Future.delayed(Duration(seconds: 1));
      
      // Add external relay
      print('🔗 Connecting to wss://relay3.openvine.co...');
      await embeddedRelay.addExternalRelay('wss://relay3.openvine.co');
      
      // Wait for connection
      await Future.delayed(Duration(seconds: 2));
      
      // Create a client to connect to the embedded relay
      final client = nostr_sdk.Client();
      await client.connect(['ws://localhost:7447']);
      
      // Subscribe to kind 32222 events (NIP-32222 addressable video events)
      print('\n📹 Subscribing to kind 32222 events...');
      
      // First batch - get most recent videos
      final filter1 = nostr_sdk.Filter(
        kinds: [32222],
        limit: 10,
      );
      
      final events1 = <nostr_sdk.Event>[];
      final sub1 = client.subscribe([filter1]);
      
      // Collect events for 3 seconds
      sub1.listen((event) {
        events1.add(event);
        print('  Got video event: ${event.id.substring(0, 8)}... created at ${DateTime.fromMillisecondsSinceEpoch(event.createdAt * 1000)}');
      });
      
      await Future.delayed(Duration(seconds: 3));
      
      print('\n📊 First batch results:');
      print('  Total events: ${events1.length}');
      
      expect(events1, isNotEmpty, reason: 'Should receive kind 32222 events from relay');
      
      // Find the oldest timestamp from first batch
      int? oldestTimestamp;
      for (final event in events1) {
        if (oldestTimestamp == null || event.createdAt < oldestTimestamp) {
          oldestTimestamp = event.createdAt;
        }
      }
      
      if (oldestTimestamp != null) {
        print('  Oldest timestamp: ${DateTime.fromMillisecondsSinceEpoch(oldestTimestamp * 1000)}');
        
        // Second batch - use pagination with 'until' parameter
        print('\n📹 Loading older videos using until parameter...');
        
        final filter2 = nostr_sdk.Filter(
          kinds: [32222],
          until: oldestTimestamp, // This is the key - get videos older than what we have
          limit: 10,
        );
        
        final events2 = <nostr_sdk.Event>[];
        final sub2 = client.subscribe([filter2]);
        
        sub2.listen((event) {
          events2.add(event);
          print('  Got older video: ${event.id.substring(0, 8)}... created at ${DateTime.fromMillisecondsSinceEpoch(event.createdAt * 1000)}');
        });
        
        await Future.delayed(Duration(seconds: 3));
        
        print('\n📊 Second batch (pagination) results:');
        print('  Total new events: ${events2.length}');
        
        // Check if second batch has different events
        final firstBatchIds = events1.map((e) => e.id).toSet();
        final newEvents = events2.where((e) => !firstBatchIds.contains(e.id)).toList();
        
        print('  Unique new events: ${newEvents.length}');
        print('  All are older: ${newEvents.every((e) => e.createdAt <= oldestTimestamp!)}');
        
        expect(newEvents, isNotEmpty, reason: 'Pagination with until parameter should return NEW older events');
        
        // Verify all new events are actually older
        for (final event in newEvents) {
          expect(
            event.createdAt,
            lessThanOrEqualTo(oldestTimestamp),
            reason: 'Paginated events should be older than or equal to the until timestamp',
          );
        }
        
        print('\n✅ SUCCESS: Pagination is working correctly!');
        print('  - Got ${events1.length} initial videos');
        print('  - Got ${newEvents.length} older videos using pagination');
        print('  - All paginated videos are properly older than initial batch');
      }
      
      // Cleanup
      await client.disconnect();
      await embeddedRelay.stop();
      
    }, timeout: Timeout(Duration(seconds: 30)));
  });
}