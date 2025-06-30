import 'package:flutter/material.dart';

class JoinedMemberTile extends StatelessWidget {
  final String name;
  final String counting;
  const JoinedMemberTile(
      {super.key, required this.name, required this.counting});

  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    final double height = screensize.height;
    final double width = screensize.width;
    return Container(
      color: Colors.white,
      width: width * 0.95,
      height: height * 0.06,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 0.06,
          ),
          Text('${counting}.', style: TextStyle(fontSize: 16)),
          SizedBox(
            width: width * 0.02,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
