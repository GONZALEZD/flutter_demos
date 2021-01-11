import 'dart:math';

import 'package:encrypted_db/card_widget.dart';
import 'package:encrypted_db/credit_card.dart';
import 'package:encrypted_db/db_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum DBLocation {
  asset,
  local,
}

extension DBLocationPath on DBLocation {
  String get path {
    switch (this) {
      case DBLocation.asset:
        return "data/encrypted_test.db";
      case DBLocation.local:
        return "encrypted.db";
    }
  }

  String get password {
    switch (this) {
      case DBLocation.asset:
        return "coucou";
      case DBLocation.local:
        return "bonjour";
    }
  }

  String get name {
    switch (this) {
      case DBLocation.asset:
        return "ASSET";
      case DBLocation.local:
        return "LOCAL";
    }
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<CreditCard> cards;

  DBService _dbService;
  DBLocation _location;

  @override
  void initState() {
    super.initState();
    this.cards = [];
    _location = DBLocation.asset;
    _loadDatabase();
  }

  void _loadDatabase() {
    _dbService = DBService(
      name: _location.path,
      password: _location.password,
      isAsset: _location == DBLocation.asset,
    );
    _getAllCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDBLocation(context),
          Expanded(child: _buildCardList()),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buildActions(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDBLocation(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: Theme.of(context).primaryColorLight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text("DB location"),
          Text(
            "[${_location.name}] ${_location.path}",
            style: TextStyle(fontSize: 20.0),
          ),
        ],
      ),
    );
  }

  void _addRandomCard() async {
    final names = [
      "Mr DUPONT",
      "Mme LOUISE",
      "Mme TELMA",
      "Mr CHRISTOPHE",
      "Mr BERGERAC",
      "Mme VEIL"
    ];
    final rand = Random();
    final randomDigitsString =
        (count) => List.generate(count, (index) => rand.nextInt(10)).toList().join();
    final card = CreditCard.card(
      lastName: names[rand.nextInt(names.length)],
      expiration: DateTime(2020 + rand.nextInt(13), 1 + rand.nextInt(12)),
      cryptogram: randomDigitsString(3),
      cardNumber: randomDigitsString(16),
      type: "BANK NAME",
    );
    int id = await _dbService.insertSensitiveData(card);
    card.id = id;
    this.cards.add(card);
    setState(() {});
  }

  void _getAllCards() async {
    this.cards = await _dbService.allCards();
    setState(() {});
  }

  void _switchDatabase() async {
    _location = _location == DBLocation.asset ? DBLocation.local : DBLocation.asset;
    _loadDatabase();
  }

  List<Widget> _buildActions(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    final buttonBuilder = (text, onPressed) {
      return FlatButton(
        onPressed: onPressed,
        child: Text(text),
        color: color,
        textColor: Colors.white,
      );
    };
    return [
      buttonBuilder("Get all Cards", _getAllCards),
      buttonBuilder("Add a Card", _addRandomCard),
      buttonBuilder("DB Switch", _switchDatabase),
    ];
  }

  Widget _buildCardList() {
    return ListView.separated(
      itemBuilder: (context, index) => Center(child: CardWidget(card: this.cards[index])),
      separatorBuilder: (_, __) => Divider(),
      itemCount: this.cards.length,
    );
  }
}
