import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Walletbutton extends StatefulWidget {
  final VoidCallback ontap;
  final String title;
  const Walletbutton({super.key, required this.ontap, required this.title});

  @override
  State<Walletbutton> createState() => _WalletbuttonState();
}

class _WalletbuttonState extends State<Walletbutton> {
  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    final double height = screensize.height;
    final double width = screensize.width;
    return InkWell(
      onTap: widget.ontap,
      child: Container(
        width: width * 0.247,
        height: height * 0.0545585068198134,
        decoration: ShapeDecoration(
          color: Color(0xFFED7A78),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFFC79993)),
            borderRadius: BorderRadius.circular(9.50),
          ),
        ),
        child: Center(
          child: Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
        ),
      ),
    );
  }
}
