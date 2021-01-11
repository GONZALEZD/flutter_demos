import 'dart:math';

import 'package:encrypted_db/credit_card.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final CreditCard card;

  CardWidget({this.card});

  @override
  State<StatefulWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool _frontSide;

  @override
  void initState() {
    super.initState();
    _frontSide = true;
  }

  CreditCard get card => this.widget.card;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 600),
        child: _frontSide ? _buildFrontSide() : _buildRearSide(),
        layoutBuilder: (widget, list) => Stack(children: [widget, ...list]),
        transitionBuilder: __transitionBuilder,
      ),
    );
  }

  void _flipCard() {
    setState(() {
      _frontSide = !_frontSide;
    });
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_frontSide) != widget.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value = isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: (Matrix4.rotationY(value)..setEntry(3, 0, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  Widget _buildFrontSide() {
    final month = this.card.expiration.month;
    final monthStr = month < 10 ? "0$month" : "$month";
    final yearStr = "${this.card.expiration.year}";
    return __buildCardLayout(
      backgroundColor: Colors.lightBlue.shade600,
      key: ValueKey(true),
      child: _FrontCardWidget(
        accountNumber: this.card.cardNumber,
        bankName: this.card.type,
        lastName: this.card.lastName,
        expirationDate: "$monthStr / $yearStr",
      ),
    );
  }

  Widget _buildRearSide() {
    return __buildCardLayout(
      backgroundColor: Colors.lightBlue.shade700,
      key: ValueKey(false),
      child: _RearCardWidget(
        cryptogram: this.card.cryptogram,
      ),
    );
  }

  Widget __buildCardLayout({Color backgroundColor, Widget child, Key key}) {
    return Card(
      key: key,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: backgroundColor,
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(width: 250.0, height: 170.0),
        child: child,
      ),
    );
  }
}

class _RearCardWidget extends StatelessWidget {
  final String cryptogram;

  _RearCardWidget({this.cryptogram});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          _buildMagneticStrip(),
          SizedBox(
            height: 6.0
          ),
          _buildCryptogramStrip(),
          Spacer(),
        ],
      ),
    );
  }

  Widget _buildMagneticStrip() {
    return Container(
      constraints: BoxConstraints.tightFor(height: 30.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey.shade800, Colors.grey.shade900],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border.symmetric(horizontal: BorderSide(color: Colors.grey.shade700, width: 2.0)),
      ),
    );
  }

  Widget _buildCryptogramStrip() {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      padding: EdgeInsets.only(right: 4.0),
      constraints: BoxConstraints.tightFor(height: 34.0),
      color: Colors.grey.shade100,
      child: Text(this.cryptogram.toUpperCase()),
    );
  }
}

class _FrontCardWidget extends StatelessWidget {
  final String lastName;
  final String bankName;
  final String accountNumber;
  final String expirationDate;

  _FrontCardWidget({this.lastName, this.bankName, this.accountNumber, this.expirationDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        child: Column(
          children: [
            _buildBankName(),
            _buildChip(),
            _buildAccountNumber(),
            _buildExpirationDate(),
            _buildLastName(),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountNumber() {
    final matches = new RegExp(r"\d{4}").allMatches(this.accountNumber);
    final numbers = matches.map((m) => m.group(0)).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: numbers.map((n) {
          return Text(n, style: TextStyle(fontSize: 18.0),);
        }).toList(),
      ),
    );
  }

  Widget _buildExpirationDate() {
    return Center(
      child: Text(this.expirationDate),
    );
  }

  Widget _buildLastName() {
    return Container(
      margin: EdgeInsets.only(top: 12.0),
      alignment: Alignment.centerLeft,
      child: Text(this.lastName.toUpperCase()),
    );
  }

  Widget _buildBankName() {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(this.bankName, style: TextStyle(fontSize: 20.0)),
    );
  }

  Widget _buildChip() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints.tightFor(width: 40.0, height: 30.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
