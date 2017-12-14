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
      title: 'Flutter JSON Parsing Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new UserListPage(),
    );
  }
}

class UserListPage extends StatefulWidget {
  UserListPage({Key key, this.url}) : super(key: key);

  final String url;

  @override
  UserListState createState() => new UserListState();
}

class UserListState extends State<UserListPage> {

  var userWidgets = <Widget>[];

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  _getUsers() async {
    
    List<Widget> widgets = [];
    var userList = await fetchAndParseUsers();
    userList.forEach((user) =>
      widgets.add(
        new ListTile(
          title: new Text(user.name),
          subtitle: new Text(user.address.toString()),
        )
      )
    );

    setState(() => this.userWidgets = widgets);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('List Example'),
      ),
      body: new ListView(children: userWidgets)
    );
  }
}

// Network and JSON parsing

final jsonEndpoint = 'https://jsonplaceholder.typicode.com/users';

class User {
  User(this.name, this.userName, this.address);

  final String name;
  final String userName;
  final Address address;

  String toString() {
    return 'name: $name\nuser name: $userName\naddress: $address';
  }
}

class Address {
  Address(this.street, this.suite, this.city, this.zipcode);

  final String street;
  final String suite;
  final String city;
  final String zipcode;

  String toString() {
    return '$street, $suite, $city, $zipcode';
  }
}

Future<List<User>> fetchAndParseUsers() async {
  var res = await http.get(jsonEndpoint);
  var jsonStr = res.body;
  var parsedUserList = JSON.decode(jsonStr);
  var userList = <User>[];
  parsedUserList.forEach((parsedUser) {
    userList.add(
      new User(
        parsedUser['name'],
        parsedUser['username'],
        new Address(
          parsedUser['address']['street'],
          parsedUser['address']['suite'],
          parsedUser['address']['city'],
          parsedUser['address']['zipcode'],
        ),
      )
    );
  });
  return userList;
}
