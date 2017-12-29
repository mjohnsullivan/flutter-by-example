// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Streamed List Example',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new ListExamplePage(),
    );
  }
}

class ListExamplePage extends StatefulWidget {
  @override
  ListExamplePageState createState() => new ListExamplePageState();
}

class ListExamplePageState extends State<ListExamplePage> {
  StreamController<Photo> photoStreamController;
  var photoList = <Photo>[];

  @override
  initState() {
    super.initState();
    photoStreamController = new StreamController<Photo>.broadcast();
    
    // Listen for photos
    photoStreamController.stream.listen(
      (photo) => setState(() => photoList.add(photo))
    );

    // Start fetching photos 
    loadPhotos(photoStreamController);
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Streamed List Example'),
        ),
        body: new ListView.builder(
          itemBuilder: (BuildContext context, int pos) =>
              _getRow(pos),
        ));
  }

  @override
  dispose() {
    super.dispose();
    photoStreamController?.close();
    photoStreamController = null;
  }

/// Returns the widget at position i in the list
  Widget _getRow(int pos) {
    if (pos >= photoList.length) {
      return null;
    }
    return new Container(
      child: new Padding(
        padding: new EdgeInsets.all(10.0),
        child: new Text(photoList[pos].title)
      )
    );
  }
}

/// Loads photos and places them in the photo stream
loadPhotos(StreamController<Photo> photoStreamController) async {
  String uri = 'https://jsonplaceholder.typicode.com/photos';
  var client = new http.Client();
  var request = new http.Request('get', Uri.parse(uri));

  var streamedResponse = await client.send(request);
  streamedResponse.stream
    .transform(UTF8.decoder)
    .transform(JSON.decoder)
    .expand((eventList) => eventList)
    .map((photoMap) => new Photo.fromJsonMap(photoMap))
    .pipe(photoStreamController);
}

/// Data class for photos
class Photo {
  final int id;
  final int albumId;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo.fromJsonMap(Map jsonMap) :
    id = jsonMap['id'],
    albumId = jsonMap['albumId'],
    title = jsonMap['title'],
    url = jsonMap['url'],
    thumbnailUrl = jsonMap['thumbnailUrl'];

  String toString() {
    return 'Photo(id: $albumId, title: $title)';
  }
}