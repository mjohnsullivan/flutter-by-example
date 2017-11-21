// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Adapted from Flutter's translation docs
// https://flutter.io/tutorials/internationalization/

// Demonstrates a smiple way to handle translations using a language map

// The pubspec.yaml file must include flutter_localizations in its
// dependencies section. For example:
//
// dependencies:
//   flutter:
//   sdk: flutter
//  flutter_localizations:
//    sdk: flutter

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter_localizations/flutter_localizations.dart';

class DemoLocalizations {
  DemoLocalizations(this.locale);

  final Locale locale;

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Translation Example',
      'statement': 'I\'m in English',
      'language_button': 'Change language',
    },
    'es': {
      'title': 'Ejemplo de traducción',
      'statement': 'Estoy en español',
      'language_button': 'Cambiar idioma',
    },
  };

  String get title {
    return _localizedValues[locale.languageCode]['title'];
  }

    String get statement {
    return _localizedValues[locale.languageCode]['statement'];
  }

  String get languageButton {
    return _localizedValues[locale.languageCode]['language_button'];
  }
}

class DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return new SynchronousFuture<DemoLocalizations>(new DemoLocalizations(locale));
  }

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}


class DemoApp extends StatelessWidget {
  DemoApp(Function changeLocale) : changeLocale = changeLocale;

  final changeLocale;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(DemoLocalizations.of(context).title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Text(DemoLocalizations.of(context).statement,
              style: Theme.of(context).textTheme.display1,),
            new RaisedButton(
              child: new Text(DemoLocalizations.of(context).languageButton),
              onPressed: () { 
                changeLocale();
                }
            )
          ],
        ),
      ),
    );
  }
}

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => new _DemoState();
}

class _DemoState extends State<Demo> {
  // Track what locale to use for display
  var _appLocale = const Locale('en', 'US');


  void _updateLocale() {
    setState(() {
            _appLocale = (_appLocale.languageCode == 'en')
              ? const Locale('es', 'US')
              : const Locale('en', 'US');
          });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      onGenerateTitle: (BuildContext context) => DemoLocalizations.of(context).title,
      locale: _appLocale,
      localizationsDelegates: [
        const DemoLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
      ],
      
      home: new DemoApp(_updateLocale),
      // Use this to set the initial locale
      localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
         return _appLocale;
       },
    );
  }
}

void main() {
  runApp(new Demo());
}