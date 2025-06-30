import 'package:flutter/material.dart';
import 'package:oneup_noobs/Utils/colors.dart';

class TornamentPageTile extends StatelessWidget {
  final VoidCallback ontap;
  final String matchtitle;
  final String matchimg;
  final String map;
  final String matchtype;
  final String date;
  final String time;
  final String prizepool;
  final String perkill;
  final String entryfees;
  final String maxparticipants;
  final String enrolledparticipants;

  const TornamentPageTile({
    super.key,
    required this.ontap,
    required this.matchimg,
    required this.map,
    required this.matchtype,
    required this.date,
    required this.time,
    required this.prizepool,
    required this.perkill,
    required this.entryfees,
    required this.matchtitle,
    required this.maxparticipants,
    required this.enrolledparticipants,
  });

  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    final double height = screensize.height;
    final double width = screensize.width;
    double progress =
        int.parse(enrolledparticipants) / int.parse(maxparticipants);
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.01),
        child: Container(
          width: width * 0.95,
          //height: height * 0.3075,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 5, // Spread radius
                blurRadius: 7, // Blur radius
                offset: Offset(0, 3), // Offset in x and y directions
              ),
            ],

            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(10),
            //side: BorderSide(width: 1, color: Color(0xFF0A1E51)),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Container(
                  // width: width * 0.8833,
                  height: height * 0.25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(matchimg),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.0133,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Container(
                    width: width * 0.170,
                    height: height * 0.028,
                    decoration: ShapeDecoration(
                      color: AppColors.orangecolor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Center(
                      child: Text(
                        matchtype,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  Container(
                    width: width * 0.170,
                    height: height * 0.028,
                    decoration: ShapeDecoration(
                      color: AppColors.greencolor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Center(
                      child: Text(
                        map,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * 0.013,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.06,
                  ),
                  Text(
                    '💣',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: width * 0.0259,
                  ),
                  Text(
                    matchtitle,
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff494c4f),
                      height: 26 / 26,
                    ),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                height: 1,
                width: width * 0.9,
                color: Colors.grey,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.03,
                  ),
                  Column(
                    children: [
                      Text(
                        date,
                        style: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.orangecolor,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.orangecolor,
                        ),
                        textAlign: TextAlign.right,
                      )
                    ],
                  ),
                  SizedBox(
                    width: width * 0.0321,
                  ),
                  Container(
                    height: height *
                        0.1, // Adjust the height of the vertical divider
                    width: 1, // Adjust the width of the vertical divider
                    color: Colors
                        .grey, // Specify the color of the vertical divider
                  ),
                  SizedBox(
                    width: width * 0.0321,
                  ),
                  Column(
                    children: [
                      Text(
                        "PRIZE POOL",
                        maxLines: 3,
                        style: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.greencolor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "${prizepool}(%)",
                        maxLines: 3,
                        style: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.greencolor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: width * 0.0321,
                  ),
                  Container(
                      height: height *
                          0.1, // Adjust the height of the vertical divider
                      width: 1, // Adjust the width of the vertical divider
                      color: Colors.grey
                      // Specify the color of the vertical divider
                      ),
                  SizedBox(
                    width: width * 0.1,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "PER",
                        style: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.bluecolor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "KILL",
                        style: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.bluecolor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "${perkill}(%)",
                        style: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.bluecolor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: 1,
                width: width * 0.9,
                color: Colors.grey,
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        '${enrolledparticipants}/${maxparticipants}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(0xFF505155),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      // Container(
                      //   width: width * 0.379,
                      //   height: height * 0.005833,
                      //   color: Color.fromARGB(255, 247, 132, 124),
                      // )
                      SizedBox(
                        width: width * 0.379,
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Color.fromARGB(255, 195, 231, 255),
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.bluecolor),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: width * 0.1,
                  ),
                  Container(
                    width: width * 0.35,
                    height: height * 0.05,
                    decoration: ShapeDecoration(
                      color: Color.fromARGB(255, 247, 132, 124),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.25),
                      ),
                    ),
                    child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            Image.asset(
                              'assets/coin.png',
                              scale: 20,
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            Text(
                              '${entryfees} JOIN ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w800,
                                height: 0,
                              ),
                            ),
                            Spacer()
                          ]),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * 0.015,
              )

              // Row(
              //   children: [
              //     Spacer(),
              //     Padding(
              //       padding: EdgeInsets.fromLTRB(
              //           width * 0.01, height * 0.0125, 0, height * 0.0125),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         children: [
              //           SizedBox(
              //             width: width * 0.5,
              //             child: Text(
              //               'eventname',
              //               style: TextStyle(
              //                 color: Colors.black,
              //                 fontSize: 18,
              //                 fontFamily: 'Sahitya',
              //                 fontWeight: FontWeight.w600,
              //                 height: 0,
              //               ),
              //             ),
              //           ),
              //           SizedBox(
              //             height: height * 0.01,
              //           ),
              //           Text(
              //             'HOST : ',
              //             style: TextStyle(
              //               color: Colors.black,
              //               fontSize: 12,
              //               // fontFamily: 'Poppins',
              //               fontWeight: FontWeight.w600,
              //               height: 0,
              //             ),
              //           ),
              //           SizedBox(
              //             height: height * 0.01,
              //           ),
              //           Text(
              //             'TIME - ',
              //             style: TextStyle(
              //               color: Colors.black,
              //               fontSize: 12,
              //               // fontFamily: 'Poppins',
              //               fontWeight: FontWeight.w600,
              //               height: 0,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     // SizedBox(
              //     //   width: width * 0.1,
              //     // ),
              //     Spacer(),
              //     Column(
              //       children: [
              //         Image.asset('assets/eventimg.png'),
              //         SizedBox(
              //           height: height * 0.01,
              //         ),
              //         Text(
              //           ' date',
              //           style: TextStyle(
              //             color: Colors.black,
              //             fontSize: 12,
              //             // fontFamily: 'Poppins',
              //             fontWeight: FontWeight.w600,
              //             height: 0,
              //           ),
              //         )
              //       ],
              //     ),
              //     Spacer(),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
