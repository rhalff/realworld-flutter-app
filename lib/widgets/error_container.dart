import 'package:flutter/material.dart';

class ErrorContainer extends StatelessWidget {
  final String title;
  final String error;
  ErrorContainer({
    this.title,
    this.error,
  }) : assert(title != null || error != null);
  @override
  Widget build(BuildContext context) {
    print(error);
    return Center(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            title ?? error.toString(),
            softWrap: true,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
