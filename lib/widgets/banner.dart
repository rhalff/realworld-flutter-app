import 'package:flutter/material.dart';

class Banner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.primaryColor,
        boxShadow: [
          const BoxShadow(
            color: Colors.black,
            offset: const Offset(0.0, 0.0),
          ),
          BoxShadow(
            color: theme.primaryColor,
            offset: const Offset(0.0, -8.0),
            blurRadius: 8.0,
            spreadRadius: -8.0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Text(
            'conduit',
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.w700,
              fontFamily: 'Titilliumweb',
              shadows: [
                Shadow(
                  blurRadius: 3.0,
                  color: Color(0X48000000),
                  offset: Offset(0, 1.0),
                ),
              ],
            ),
          ),
          const Text(
            'A place to share your knowledge.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              height: 1.5,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
