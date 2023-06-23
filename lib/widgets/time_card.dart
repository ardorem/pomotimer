import 'package:flutter/material.dart';

class TimeCard extends StatefulWidget {
  final int timeToPomo;
  const TimeCard({
    super.key,
    required this.timeToPomo,
  });

  @override
  State<TimeCard> createState() => _TimeCardState();
}

class _TimeCardState extends State<TimeCard> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 10,
        ),
        side: BorderSide(width: 3.0, color: Colors.white.withOpacity(0.5)),
      ),
      onPressed: () {
        debugPrint('Received click');
      },
      child: Text(
        widget.timeToPomo.toString(),
        style: const TextStyle(
            fontSize: 25, fontWeight: FontWeight.w800, color: Colors.white),
      ),
    );
  }
}
