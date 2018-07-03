// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// You must generate the JSON code first
// Run this in the project root: 'flutter pub pub run build_runner build'

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'data.dart';

const String urlPrefix = 'https://hacker-news.firebaseio.com/v0/';
const String urlTopStories = '${urlPrefix}topstories.json?print=pretty';
const String urlItem = '${urlPrefix}item/ID.json';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSON Serializable Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JSON Serializable Demo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: HackerNewsStoryIds(),
      ),
    );
  }
}

class HackerNewsStoryIds extends StatelessWidget {
  Future<List<int>> getStoryIds() async {
    final res = await http.get(urlTopStories);
    if (res.statusCode == 200) {
      final storyIdsList = json.decode(res.body);
      return parseStoryIds(storyIdsList);
    }
    throw ('Network error');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getStoryIds(),
        builder: (context, AsyncSnapshot<List<int>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error);
            } else
              return _HackerNewsStoryIds(snapshot.data);
          } else
            return Center(child: CircularProgressIndicator());
        });
  }
}

class _HackerNewsStoryIds extends StatelessWidget {
  final List<int> storyIds;
  _HackerNewsStoryIds(this.storyIds);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: storyIds
            .map((id) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    child: Text(id.toString()),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HackerNewsStoryPage(id),
                        )),
                  ),
                ))
            .toList());
  }
}

class HackerNewsStoryPage extends StatelessWidget {
  final int storyId;
  HackerNewsStoryPage(this.storyId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Story'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: HackerNewsStory(storyId),
        ));
  }
}

class HackerNewsStory extends StatelessWidget {
  final int id;
  HackerNewsStory(this.id);

  Future<Story> getStory() async {
    final res = await http.get(urlItem.replaceAll(RegExp('ID'), id.toString()));
    if (res.statusCode == 200) {
      final storyMap = json.decode(res.body);
      return Story.fromJson(storyMap);
    }
    throw ('Network error');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getStory(),
        builder: (context, AsyncSnapshot<Story> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error);
            } else
              return _HackerNewsStory(snapshot.data);
          } else
            return Center(child: CircularProgressIndicator());
        });
  }
}

class _HackerNewsStory extends StatelessWidget {
  final Story story;
  _HackerNewsStory(this.story);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        story.title,
        style: Theme.of(context).textTheme.title,
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 20.0),
      FlatButton(
        child: Text(story.url),
        onPressed: () => _launchURL(story.url),
      )
    ]);
  }
}

_launchURL(final String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}
