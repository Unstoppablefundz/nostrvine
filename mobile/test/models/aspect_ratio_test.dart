import 'package:flutter_test/flutter_test.dart';
import 'package:openvine/models/aspect_ratio.dart';

void main() {
  group('AspectRatio', () {
    test('has square value', () {
      expect(AspectRatio.square, isNotNull);
    });

    test('has vertical value', () {
      expect(AspectRatio.vertical, isNotNull);
    });

    test('square is default (first enum value)', () {
      expect(AspectRatio.values.first, equals(AspectRatio.square));
    });
  });
}
