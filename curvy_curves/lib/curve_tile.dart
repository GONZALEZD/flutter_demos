import 'package:curvy_curves/named_curves.dart';
import 'package:flutter/material.dart';

class CurveTile extends StatelessWidget {
  final String curveName;
  final bool curveFlipped;
  final int curveIndex;
  final Function(String name) onChanged;
  final Function(bool isFlipped) onFlipped;
  final bool deletable;
  final Function() onDelete;

  CurveTile(
      {this.curveName,
      this.curveFlipped,
      this.curveIndex,
      this.onChanged,
      this.onFlipped,
      this.deletable,
      this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        __buildCurveRowIdentifier(context),
        DropdownButton(
            value: this.curveName,
            items: NamedCurves.names.map((curveName) {
              return DropdownMenuItem(child: Text(curveName), value: curveName);
            }).toList(),
            onChanged: this.onChanged),
        _buildCheck(context),
        _buildDeleteButton(context),
      ],
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: this.deletable ? this.onDelete : null,
      child: Icon(
        Icons.delete,
        color: this.deletable ? theme.primaryColor : Colors.grey.shade300,
      ),
    );
  }

  Widget _buildCheck(BuildContext context) {
    return FlatButton.icon(
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      textColor: Colors.white,
      onPressed: () => this.onFlipped(!this.curveFlipped),
      icon: Icon(
        this.curveFlipped ? Icons.check_box_outlined : Icons.check_box_outline_blank,
        color: Colors.white,
      ),
      label: Text("flip"),
    );
  }

  Widget __buildCurveRowIdentifier(BuildContext context) {
    return Container(
      width: 32.0,
      height: 32.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
      child: Text(
        "${this.curveIndex + 1}",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
