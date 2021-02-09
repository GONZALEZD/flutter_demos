import 'package:flutter/material.dart';
import 'package:web_shortcuts/src/people_tile.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<People> _people;

  @override
  void initState() {
    super.initState();
    _people = _generatePeople();
  }

  _generatePeople() {
    final data = [
      {'name': 'Elodie', 'lastName': 'DUPONT', 'role': 'Human Resources'},
      {'name': 'Nicolas', 'lastName': 'DURAND', 'role': 'Engineer'},
      {'name': 'Jean', 'lastName': 'PETIT', 'role': 'Tech lead'},
      {'name': 'Camille', 'lastName': 'MARTIN', 'role': 'Engineer'},
      {
        'name': 'Thomas',
        'lastName': 'BERNARD',
        'role': 'Chief Technical Officer'
      },
      {
        'name': 'Nicolas',
        'lastName': 'ROBERT',
        'role': 'Chief Executive Officer'
      },
      {'name': 'Adrien', 'lastName': 'RICHARD', 'role': 'Chairman'},
      {
        'name': 'Céline',
        'lastName': 'BUBOIS',
        'role': 'Chief Marketing Officer'
      },
      {
        'name': 'Marine',
        'lastName': 'MOREAU',
        'role': 'Chief Financial Officer'
      },
      {'name': 'Michelle', 'lastName': 'SIMON', 'role': 'Engineer'},
    ];
    return data.map((d) {
      return People(
          firstName: d['name'],
          lastName: d['lastName'],
          role: d['role'],
          photo: 'assets/photo${data.indexOf(d)}.jpg',
          company: 'AWESOME Corp');
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('People in AWESOME Corp.'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => PeopleTile(
          people: _people[index],
        ),
        separatorBuilder: (_, __) => Divider(
          height: 40.0,
        ),
        itemCount: _people.length,
      ),
    );
  }
}
