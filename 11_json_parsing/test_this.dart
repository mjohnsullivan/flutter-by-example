import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

final jsonEndpoint = 'https://jsonplaceholder.typicode.com/users';

class User {
  User(this.name, this.userName, this.address);

  String name;
  String userName;
  Address address;

  String toString() {
    return 'name: $name\nuser name: $userName\naddress: $address';
  }
}

class Address {
  Address(this.street, this.suite, this.city, this.zipcode);

  String street;
  String suite;
  String city;
  String zipcode;

  String toString() {
    return '$street, $suite, $city, $zipcode';
  }
}

main() async {
  parseJSON().then((users) =>
    users.forEach((user) => print('$user\n'))
  );
}

Future<List<User>> parseJSON() async {
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