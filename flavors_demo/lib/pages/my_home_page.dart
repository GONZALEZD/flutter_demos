import 'package:flutter/material.dart';

import '../flavors.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("COUCOU Page");
    return F.layoutBuilder(
        context,
        Scaffold(
          appBar: AppBar(
            title: Text(F.data.title),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Hello ${F.data.title}',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40.0,
              ),
              Counter(),
            ],
          ),
        ));
  }
}

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int credit;

  @override
  void initState() {
    super.initState();
    this.credit = 100;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Current credit: $credit"),
        FlatButton.icon(
          onPressed: this.applyBonus,
          color: Colors.deepPurple,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          icon: Icon(Icons.monetization_on_rounded),
          label: Text("Add bonus"),
        ),
      ],
    );
  }

  void applyBonus() {
    setState(() {
      this.credit = F.data.applyBonus(currentCredit: this.credit);
    });
  }
}
