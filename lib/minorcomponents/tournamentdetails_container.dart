import 'package:flutter/material.dart';

class TournamentDetailsContainer extends StatelessWidget {
  final String title;
  final String value;
  const TournamentDetailsContainer(
      {super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    final double height = screensize.height;
    final double width = screensize.width;
    return Container(
      // alignment: Alignment.center,
      //  width: 171,
      height: height * 0.040,
      decoration: ShapeDecoration(
        color: Color(0xFFFDFDFD),
        shadows: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 1, // Spread radius
            blurRadius: 2, // Blur radius
            offset: Offset(0, 2), // Offset in x and y directions
          ),
        ],
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2, color: Color(0xFFEDEDED)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(10.50),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.02, vertical: height * 0.005),
        child: Text(
          '$title : $value',
          style: TextStyle(
            color: Color(0xFF545657),
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            // height: 0,
          ),
        ),
      ),
    );
  }
}
