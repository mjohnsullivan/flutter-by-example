// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(NetworkApp());
}

class NetworkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: NetworkBody()),
    );
  }
}

class NetworkBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Quotation(url: 'https://quotes.rest/qod.json'),
          Padding(padding: EdgeInsets.only(top: 50.0)),
          Image
              .network('https://flutter.io/images/flutter-mark-square-100.png'),
        ],
      ),
    );
  }
}

/// The first line of a HTTP request body
class Quotation extends StatefulWidget {
  Quotation({Key key, this.url}) : super(key: key);

  final String url;

  @override
  createState() => _QuotationState();
}

class _QuotationState extends State<Quotation> {
  String data = 'Loading ...';

  @override
  void initState() {
    super.initState();
    _get();
  }

  _get() async {
    final res = await http.get(widget.url);
    setState(() => data = _parseQuoteFromJson(res.body));
  }

  String _parseQuoteFromJson(String jsonStr) {
    // In the real world, this should check for errors
    final jsonQuote = json.decode(jsonStr);
    return jsonQuote['contents']['quotes'][0]['quote'];
  }

  @override
  Widget build(BuildContext context) {
    return Text(data, textAlign: TextAlign.center);
  }
}
