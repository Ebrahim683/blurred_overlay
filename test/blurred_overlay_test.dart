import 'package:flutter_test/flutter_test.dart';
import 'package:blurred_overlay/blurred_overlay.dart';

void main() {
  test('blurred_overlay package imports successfully', () {
    // Simple test to verify the package can be imported
    expect(showBlurredDialog, isNotNull);
    expect(showBlurredModalBottomSheet, isNotNull);
  });
}