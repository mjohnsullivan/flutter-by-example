/// Example tests for streams

import 'dart:async';

import 'package:test/test.dart';
import 'package:testing/testing.dart';

void main() {
  test('stream emits 3 events', () {
    expect(Stream.fromIterable([1, 2, 3]), emitsInOrder([1, 2, 3, emitsDone]));
  });
}
