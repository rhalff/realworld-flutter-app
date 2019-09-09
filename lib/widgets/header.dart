import 'package:flutter/material.dart';

@immutable
class Header extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsets padding;
  final Widget child;
  const Header({
    this.title,
    this.subtitle,
    this.color,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.padding = EdgeInsets.zero,
    this.child,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final _color = color ?? theme.primaryColor;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: _color,
        boxShadow: [
          const BoxShadow(
            color: Colors.black,
            offset: Offset(0.0, 0.0),
          ),
          BoxShadow(
            color: _color,
            offset: const Offset(0.0, -8.0),
            blurRadius: 8.0,
            spreadRadius: -8.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: crossAxisAlignment,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.w700,
              fontFamily: 'Titilliumweb',
              shadows: [
                const Shadow(
                  blurRadius: 3.0,
                  color: Color(0X48000000),
                  offset: Offset(0, 1.0),
                ),
              ],
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                height: 1.5,
                fontWeight: FontWeight.w300,
              ),
            ),
          if (child != null) child,
        ],
      ),
    );
  }
}
