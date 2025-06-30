import 'package:flutter/material.dart';
import 'package:oneup_noobs/Utils/colors.dart';

class TransactionHistoryTile extends StatelessWidget {
  final String amount;
  final String upiid;
  final bool sucess;
  final String date;
  const TransactionHistoryTile(
      {super.key,
      required this.amount,
      required this.upiid,
      required this.sucess,
      required this.date});

  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    final double height = screensize.height;
    final double width = screensize.width;
    return Container(
      width: width * 0.85,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blueGrey)),
      child: Row(
        children: [
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                '₹ ${amount}',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'UPI ID: ${upiid}',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'Date: ${date}',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: height * 0.01,
              )
            ],
          ),
          Spacer(),
          sucessfailure(sucess, context),
          Spacer()
        ],
      ),
    );
  }
}

Widget sucessfailure(bool value, BuildContext context) {
  final Size screensize = MediaQuery.of(context).size;
  final double height = screensize.height;
  final double width = screensize.width;
  if (value == false) {
    return Container(
      width: width * 0.220,
      height: height * 0.038,
      decoration: ShapeDecoration(
        color: AppColors.orangecolor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Center(
        child: Text(
          "Pending",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  } else {
    return Container(
      width: width * 0.220,
      height: height * 0.038,
      decoration: ShapeDecoration(
        color: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Center(
        child: Text(
          "Sucesss",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
