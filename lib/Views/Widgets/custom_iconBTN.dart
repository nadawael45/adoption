import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomIconBtn extends StatefulWidget {
  var onPressed;
  var icon;
  Color color;

  CustomIconBtn({this.onPressed, this.icon,this.color=Colors.white});

  @override
  _CustomIconBtnState createState() => _CustomIconBtnState();
}

class _CustomIconBtnState extends State<CustomIconBtn> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: widget.color,
      child: IconButton(
          onPressed: widget.onPressed,
          icon: widget.icon,




      ),
    );
  }
}
