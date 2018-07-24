import 'package:flutter/material.dart';
import 'package:forms/pretty.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyFormPage(),
    );
  }
}

class MyFormPage extends StatefulWidget {
  @override
  createState() => MyFormPageState();
}

class MyFormPageState extends State<MyFormPage> {
  String _inputText = '';

  void _updateText(String text) => setState(() => _inputText = text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Flutter Basic Form'), actions: [
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: () => navigateToPretty(context),
          )
        ]),
        body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyForm(_updateText),
                SizedBox(height: 20.0),
                Text(_inputText, style: Theme.of(context).textTheme.display1),
              ],
            )));
  }
}

class MyForm extends StatelessWidget {
  final textController = TextEditingController();
  final Function(String) updateText;

  MyForm(this.updateText);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: TextField(controller: textController)),
      SizedBox(width: 10.0),
      FlatButton(
          child: Text('Submit'),
          onPressed: () => updateText(textController.text)),
    ]);
  }
}

void navigateToPretty(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return MyPrettyFormPage();
  }));
}
