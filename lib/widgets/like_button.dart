import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool _pressed = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {},
      onHighlightChanged: (bool val) {
        setState(() {
          if (val) {
            _pressed = true;
          } else {
            _pressed = false;
          }
        });
      },
      onHover: (_) {
        setState(() => _pressed = true);
      },
      onTapCancel: () {
        setState(() => _pressed = false);
      },
      child: Container(
        padding: EdgeInsets.only(
          top: 5.0,
          bottom: 5.0,
          left: 12.0,
          right: 12.0,
        ),
        decoration: BoxDecoration(
          color: _pressed ? theme.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: theme.primaryColor,
          ),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.ac_unit,
              size: 14,
              color: _pressed ? Colors.white : theme.primaryColor,
            ),
            Text(
              '29',
              style: TextStyle(
                color: _pressed ? Colors.white : theme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
