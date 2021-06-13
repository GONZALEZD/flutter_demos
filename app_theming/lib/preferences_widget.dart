import 'package:flutter/material.dart';

class PreferencesWidget extends StatefulWidget {
  @override
  _PreferencesWidgetState createState() => _PreferencesWidgetState();
}

class _PreferencesWidgetState extends State<PreferencesWidget> {
  TextEditingController _textController;
  bool _switchChecked;
  bool _checkboxTicked;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _switchChecked = true;
    _checkboxTicked = true;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildTextInputField(),
        _buildSwitch(),
        _buildCheckBox(),
      ],
    );
  }

  Widget _buildTextInputField() {
    return __buildRow(
      title: "Text field theme",
      child: SizedBox.fromSize(
        size: Size(200.0, 60.0),
        child: Center(
          child: TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: "Write a sentence here",
              labelText: "sentence",
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSwitch() {
    return __buildRow(
      title: "Switch theme",
      child: Switch.adaptive(
        activeColor: Theme.of(context).toggleableActiveColor,
        value: _switchChecked,
        onChanged: (value) => setState(() => _switchChecked = value),
      ),
    );
  }

  Widget _buildCheckBox() {
    return __buildRow(
      title: "Checkbox theme",
      child: Checkbox(
        value: _checkboxTicked,
        onChanged: (value) => setState(() => _checkboxTicked = value),
      ),
    );
  }

  Widget __buildRow({String title, Widget child}) => Card(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Expanded(
              child: Text(title, style: Theme.of(context).textTheme.bodyText1),
          ),
          child,
        ]),
      ));
}
