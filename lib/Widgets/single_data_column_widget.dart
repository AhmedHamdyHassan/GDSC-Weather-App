import 'package:flutter/material.dart';

class SingleDataColumnWidget extends StatelessWidget {
  const SingleDataColumnWidget({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFBDC2D8),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          data,
          style: const TextStyle(
            color: Color(0xFF697088),
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
