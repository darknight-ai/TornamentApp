import 'package:flutter/material.dart';
import 'package:oneup_noobs/Utils/colors.dart';

class ItemCardAccount extends StatelessWidget {
  final String title;
  final IconData iconname;
  final VoidCallback ontap;
  const ItemCardAccount(
      {super.key,
      required this.title,
      required this.iconname,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double height = screenSize.height;
    final double width = screenSize.width;
    return InkWell(
      onTap: ontap,
      child: Container(
        width: width * 0.9,
        height: height * 0.07,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Color.fromARGB(255, 214, 214, 214))),
        child: Row(
          children: [
            SizedBox(
              width: width * 0.02,
            ),
            Icon(
              iconname,
              color: AppColors.greencolor,
            ),
            SizedBox(
              width: width * 0.05,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
