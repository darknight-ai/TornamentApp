import 'package:flutter/cupertino.dart';

class Wallettext extends StatefulWidget {
  final String title;
  const Wallettext({super.key, required this.title});

  @override
  State<Wallettext> createState() => _WallettextState();
}

class _WallettextState extends State<Wallettext> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Text(
        widget.title,
        style: TextStyle(
          color: Color(0xFF344F4C),
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w800,
          height: 0,
        ),
      ),
    ]);
  }
}
