import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  final num favorites;
  final bool favorited;
  final VoidCallback onTap;
  FavoriteButton({
    Key key,
    this.favorites = 0,
    this.favorited = false,
    this.onTap,
  }) : super(key: key);
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _pressed = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: widget.onTap,
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
              widget.favorites.toString(),
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
