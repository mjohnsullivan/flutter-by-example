/// To run this test, run 'flutter driver'

import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  // Sets the output directory for the test results to the
  // FLUTTER_DRIVER_RESULTS env setting, if available
  String resultsDirectory =
    Platform.environment['FLUTTER_DRIVER_RESULTS'] ?? '/tmp';
  print('Results directory is $resultsDirectory');

  // Tests tapping the increment button
  group('increment button test', () {
    FlutterDriver driver;

    setUpAll(() async {
      // Connect to the app
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        // Disconnect from the app
        driver.close();
      }
    });

    test('measure', () async {
      // Record the performance timeline of things that happen
      Timeline timeline = await driver.traceAction(() async {
        // Find the increment button
        SerializableFinder incrementButton = find.byValueKey(
            'increment_button');

        // Click the button 10 times
        for (int i = 0; i < 10; i++) {
          await driver.tap(incrementButton);

          // Emulate time for a user's finger between taps
          await new Future<Null>.delayed(new Duration(milliseconds: 200));
        }

      });
      // Summarise the captured data and write to files
        TimelineSummary summary = new TimelineSummary.summarize(timeline);
        summary.writeSummaryToFile('increment_perf',
            destinationDirectory: resultsDirectory, pretty: true);
        summary.writeTimelineToFile('increment_perf',
            destinationDirectory: resultsDirectory, pretty: true);
    });
  });
}