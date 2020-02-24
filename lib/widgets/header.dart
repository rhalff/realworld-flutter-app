import 'package:flutter/material.dart';

@immutable
class Header extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsets padding;
  final Widget child;
  final bool disableBoxShadow;
  final double width;
  final double height;
  final BoxFit fit;

  const Header({
    this.title,
    this.subtitle,
    this.color,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.padding = EdgeInsets.zero,
    this.width,
    this.height,
    this.child,
    this.disableBoxShadow = false,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final _color = color ?? theme.primaryColor;

    List<BoxShadow> boxShadow;

    if (!disableBoxShadow) {
      boxShadow = [
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
      ];
    }

    return Material(
      // For Hero text transition: https://github.com/flutter/flutter/issues/30647#issuecomment-509712719
      type: MaterialType.transparency,
      child: Container(
        padding: padding,
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: _color,
          boxShadow: boxShadow,
        ),
        child: fit != null
            ? FittedBox(
                fit: fit,
                child: _buildHeader(),
              )
            : _buildHeader(),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment,
      children: <Widget>[
        if (title != null)
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
    );
  }
}
