import 'package:flutter/material.dart';

class People {
  final String firstName;
  final String lastName;
  final String photo;
  final String role;
  final String company;

  People({this.firstName, this.lastName, this.photo, this.role, this.company});
}

class PeopleTile extends StatelessWidget {
  final People people;


  PeopleTile({this.people});


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30.0,
        backgroundImage: ExactAssetImage(people.photo),
      ),
      title: Text('${people.firstName} ${people.lastName.toUpperCase()}'),
      subtitle: Text('${people.role} @ ${people.company}'),
    );
  }
}