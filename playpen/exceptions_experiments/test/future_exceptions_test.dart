import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('FutureBuilder handles future completion', (tester) async {
    Future<String> futureExceptionThrower() async {
      String res = await Future.delayed(Duration(microseconds: 1), () {
        return 'future string';
      });
      return res;
    }

    await tester.pumpWidget(Builder(
      builder: (context) => FutureBuilder(
          future: futureExceptionThrower(),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text(
                  snapshot.error,
                  textDirection: TextDirection.ltr,
                );
              }
              return Text(
                snapshot.data,
                textDirection: TextDirection.ltr,
              );
            }
            return CircularProgressIndicator();
          }),
    ));

    await tester.pumpAndSettle();
    expect(find.text('future string'), findsOneWidget);
  });

  testWidgets('FutureBuilder handles exceptions', (tester) async {
    Future<String> futureExceptionThrower() async {
      String res = await Future.delayed(Duration(microseconds: 1), () {
        throw Exception('future boom');
      });
      return res;
    }

    await tester.pumpWidget(Builder(
      builder: (context) => FutureBuilder(
          future: futureExceptionThrower(),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text(
                  '${snapshot.error}',
                  textDirection: TextDirection.ltr,
                );
              }
              return Text(
                snapshot.data,
                textDirection: TextDirection.ltr,
              );
            }
            return CircularProgressIndicator();
          }),
    ));

    await tester.pumpAndSettle();
    expect(find.text('Exception: future boom'), findsOneWidget);
  });

  testWidgets('FutureBuilder handles chained futures', (tester) async {
    Future<int> futureExceptionThrower() async {
      return await Future.delayed(Duration(microseconds: 1), () {
        return 10;
      });
    }

    Future<String> intermediateFuture() async {
      final int num = await futureExceptionThrower();
      return 'Number is $num';
    }

    await tester.pumpWidget(Builder(
      builder: (context) => FutureBuilder(
          future: intermediateFuture(),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text(
                  '${snapshot.error}',
                  textDirection: TextDirection.ltr,
                );
              }
              return Text(
                snapshot.data,
                textDirection: TextDirection.ltr,
              );
            }
            return CircularProgressIndicator();
          }),
    ));

    await tester.pumpAndSettle();
    expect(find.text('Number is 10'), findsOneWidget);
  });

  testWidgets('FutureBuilder handles exceptions through chained futures',
      (tester) async {
    Future<int> futureExceptionThrower() async {
      return await Future.delayed(Duration(microseconds: 1), () {
        throw Exception('chained future boom');
      });
    }

    Future<String> intermediateFuture() async {
      final int num = await futureExceptionThrower();
      return 'Number is $num';
    }

    await tester.pumpWidget(Builder(
      builder: (context) => FutureBuilder(
          future: intermediateFuture(),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text(
                  '${snapshot.error}',
                  textDirection: TextDirection.ltr,
                );
              }
              return Text(
                snapshot.data,
                textDirection: TextDirection.ltr,
              );
            }
            return CircularProgressIndicator();
          }),
    ));

    await tester.pumpAndSettle();
    expect(find.text('Exception: chained future boom'), findsOneWidget);
  });
}
