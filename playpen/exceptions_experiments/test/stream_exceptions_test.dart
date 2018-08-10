import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('StreamBuilder handles stream events', (tester) async {
    Stream<int> streamExceptionThrower() {
      return Stream.periodic(Duration(milliseconds: 10), (i) {
        return i;
      });
    }

    await tester.pumpWidget(Builder(
      builder: (context) => StreamBuilder(
          stream: streamExceptionThrower(),
          builder: (context, AsyncSnapshot<int> snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasError) {
                return Text(
                  '${snapshot.error}',
                  textDirection: TextDirection.ltr,
                );
              }
              return Text(
                'Number is ${snapshot.data}',
                textDirection: TextDirection.ltr,
              );
            }
            return Text(
              'waiting',
              textDirection: TextDirection.ltr,
            );
          }),
    ));

    expect(find.text('waiting'), findsOneWidget);
    await tester.pumpAndSettle(Duration(milliseconds: 10));
    expect(find.text('Number is 0'), findsOneWidget);
    await tester.pumpAndSettle(Duration(milliseconds: 10));
    expect(find.text('Number is 1'), findsOneWidget);
  });

  testWidgets('StreamBuilder handles exceptions', (tester) async {
    Stream<int> streamExceptionThrower() {
      return Stream.periodic(Duration(milliseconds: 10), (i) {
        if (i == 2) {
          throw Exception('stream boom');
        }
        return i;
      });
    }

    await tester.pumpWidget(Builder(
      builder: (context) => StreamBuilder(
          stream: streamExceptionThrower(),
          builder: (context, AsyncSnapshot<int> snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasError) {
                return Text(
                  '${snapshot.error}',
                  textDirection: TextDirection.ltr,
                );
              }
              return Text(
                'Number is ${snapshot.data}',
                textDirection: TextDirection.ltr,
              );
            }
            return Text(
              'waiting',
              textDirection: TextDirection.ltr,
            );
          }),
    ));

    expect(find.text('waiting'), findsOneWidget);
    await tester.pumpAndSettle(Duration(milliseconds: 10));
    expect(find.text('Number is 0'), findsOneWidget);
    await tester.pumpAndSettle(Duration(milliseconds: 10));
    expect(find.text('Number is 1'), findsOneWidget);
    await tester.pumpAndSettle(Duration(milliseconds: 10));
    expect(find.text('Exception: stream boom'), findsOneWidget);
  });

  testWidgets('StreamBuilder handles chained stream exceptions',
      (tester) async {
    Stream<int> streamExceptionThrower() {
      final stream = Stream.periodic(Duration(milliseconds: 10), (i) {
        if (i == 2) {
          throw Exception('stream boom');
        }
        return i;
      });
      return stream.take(3);
    }

    Stream<String> intermediateStream(Stream<int> incomingStream) {
      final c = StreamController<String>();
      final sub = incomingStream.listen((i) => c.add('$i'));
      sub.onError((e) {
        // Don't re-throw error; add it to the outgoing stream instead
        c.addError(e);
      });
      // When the intermediate stream is cancelled, cancel the periodic stream
      c.onCancel = () => sub.cancel();

      return c.stream;
    }

    await tester.pumpWidget(Builder(
      builder: (context) => StreamBuilder(
          stream: intermediateStream(streamExceptionThrower()),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasError) {
                return Text(
                  '${snapshot.error}',
                  textDirection: TextDirection.ltr,
                );
              }
              return Text(
                'Number is ${snapshot.data}',
                textDirection: TextDirection.ltr,
              );
            }
            return Text(
              'waiting',
              textDirection: TextDirection.ltr,
            );
          }),
    ));

    expect(find.text('waiting'), findsOneWidget);
    await tester.pumpAndSettle(Duration(milliseconds: 10));
    expect(find.text('Number is 0'), findsOneWidget);
    await tester.pumpAndSettle(Duration(milliseconds: 10));
    expect(find.text('Number is 1'), findsOneWidget);
    await tester.pumpAndSettle(Duration(milliseconds: 10));
    expect(find.text('Exception: stream boom'), findsOneWidget);
  });
}
