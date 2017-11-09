import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Padding(padding: new EdgeInsets.only(top: 50.0),
        child: new Column(children: <Widget>[
          new FetchTextWidget(url: 'https://api.stackexchange.com/2.2/search?intitle=flutter&site=stackoverflow'),
          new Padding(padding: new EdgeInsets.only(top: 50.0)),
          new FetchImageWidget(url: 'https://flutter.io/images/flutter-mark-square-100.png'),
        ])
      )
    );
  }
}

/// The first line of a HTTP request body
class FetchTextWidget extends StatefulWidget {
  FetchTextWidget({Key key, this.url}) : super(key: key);

  final String url;

  @override
  _FetchTextState createState() => new _FetchTextState();
}

class _FetchTextState extends State<FetchTextWidget> {
  String data = 'Loading ...';

  _get() async {
    var res = await http.get(widget.url);
    setState(() => data = res.body);
  }

  @override
  void initState() {
    super.initState();
    _get();
  }

  @override
  Widget build(BuildContext context) {
    return new Text(data, textDirection: TextDirection.ltr, overflow: TextOverflow.ellipsis);
  }
}

/// Fetch an image over the network and add to a widget
class FetchImageWidget extends StatelessWidget {
  FetchImageWidget({this.url});

  final String url;

   @override
  Widget build(BuildContext context) {
    return new Image.network(url);
  }
}
