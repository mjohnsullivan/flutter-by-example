import 'package:flutter/material.dart';

class MyPrettyFormPage extends StatefulWidget {
  @override
  createState() => MyPrettyFormPageState();
}

class MyPrettyFormPageState extends State<MyPrettyFormPage> {
  String _inputText = '';

  void _updateText(String text) => setState(() => _inputText = text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Flutter Pretty Form')),
        body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyPrettyForm(_updateText),
                SizedBox(height: 20.0),
                Text(_inputText, style: Theme.of(context).textTheme.display1),
              ],
            )));
  }
}

class MyPrettyForm extends StatelessWidget {
  final textController = TextEditingController();
  final Function(String) updateText;

  MyPrettyForm(this.updateText);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: TextField(
        controller: textController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.chevron_right),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: 'Enter text here',
          labelText: 'Text Input',
        ),
      )),
      SizedBox(width: 10.0),
      Material(
        elevation: 12.0,
        color: Colors.green,
        child: InkWell(
          onTap: () => updateText(textController.text),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
    ]);
  }
}
