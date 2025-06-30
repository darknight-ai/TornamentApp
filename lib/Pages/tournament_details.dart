import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oneup_noobs/Pages/Wallet/mywallet.dart';
import 'package:oneup_noobs/Pages/Wallet/userauthenticationtype.dart';
import 'package:oneup_noobs/Pages/joiningmatch.dart';
import 'package:oneup_noobs/Utils/colors.dart';
import 'package:oneup_noobs/Utils/joinedmembertile.dart';
import 'package:oneup_noobs/Utils/widget.dart';
import 'package:oneup_noobs/minorcomponents/tournamentdetails_container.dart';

class TournamentDetails extends StatefulWidget {
  final String map;
  final String entryfees;
  final String team;
  final String date;
  final String time;
  final String prizepool;
  final String perkill;
  final String matchid;
  final String game;
  final String img;
  final String matchtitle;
  final String roomid;
  final List partcipantlist;
  final bool matchended;

  const TournamentDetails(
      {super.key,
      required this.map,
      required this.entryfees,
      required this.team,
      required this.date,
      required this.time,
      required this.prizepool,
      required this.perkill,
      required this.matchid,
      required this.game,
      required this.img,
      required this.matchtitle,
      required this.roomid,
      required this.partcipantlist,
      required this.matchended});

  @override
  State<TournamentDetails> createState() => _TournamentDetailsState();
}

class _TournamentDetailsState extends State<TournamentDetails> {
  late DatabaseReference databaseRef;
  bool isMatchJoined = false;
  bool isTournamentStarted = false;
  bool showParticipants = false;
  late Timer _countdownTimer;
  Duration _remainingTime = Duration.zero;
  Color textcolor1 = Colors.white;
  Color textcolor2 = Colors.black;
  @override
  void initState() {
    super.initState();
    _checkMatchJoined();
    _startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    final double height = screensize.height;
    final double width = screensize.width;
    return Scaffold(
      backgroundColor: AppColors.greycolor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          widget.matchtitle,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.bluecolor,
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.015,
          ),
          Column(children: [
            Center(
              child: Container(
                width: width * 0.953,
                height: height * 0.229,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.img),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Container(
              width: width * 0.953,
              height: height * 0.05,
              color: AppColors.bluecolor,
              child: Row(
                children: [
                  Spacer(),
                  TextButton(
                      onPressed: () {
                        toggleParticipants(1);
                      },
                      child: Text(
                        'DISCRIPTION',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: textcolor1),
                      )),
                  Spacer(),
                  TextButton(
                      onPressed: () {
                        toggleParticipants(2);
                      },
                      child: Text(
                        'JOINED MEMBERS',
                        style: TextStyle(
                          fontSize: 14,
                          color: textcolor2,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                  Spacer()
                ],
              ),
            )
          ]),
          SizedBox(
            height: height * 0.015,
          ),
          Expanded(
            child: showParticipants
                ? ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: widget.partcipantlist.length,
                    itemBuilder: (context, index) {
                      return JoinedMemberTile(
                        counting: (index + 1).toString(),
                        name: widget.partcipantlist[index].toString(),
                      );
                    },
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(children: [
                          SizedBox(
                            width: width * 0.04,
                          ),
                          Text(
                            widget.matchtitle,
                            style: TextStyle(
                              color: AppColors.greencolor,
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: width * 0.04,
                            ),
                            TournamentDetailsContainer(
                              title: 'Team',
                              value: widget.team,
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            TournamentDetailsContainer(
                              title: 'Entry Fee 🪙',
                              value: widget.entryfees,
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: width * 0.04,
                            ),
                            TournamentDetailsContainer(
                              title: 'Match Type',
                              value: 'PAID',
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            TournamentDetailsContainer(
                              title: 'Map',
                              value: widget.map,
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: width * 0.04,
                            ),
                            TournamentDetailsContainer(
                              title: 'Match Schedule',
                              value: '${widget.date} ${widget.time}',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.025,
                        ),
                        Row(children: [
                          SizedBox(
                            width: width * 0.04,
                          ),
                          Text(
                            'Price Details',
                            style: TextStyle(
                              color: AppColors.greencolor,
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: width * 0.04,
                            ),
                            TournamentDetailsContainer(
                              title: 'WinningPrize',
                              value: widget.prizepool,
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            TournamentDetailsContainer(
                              title: 'Per Kill',
                              value: widget.perkill,
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.025,
                        ),
                        Row(children: [
                          SizedBox(
                            width: width * 0.04,
                          ),
                          Text(
                            'About This Match',
                            style: TextStyle(
                              color: AppColors.greencolor,
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Row(children: [
                          SizedBox(
                            width: width * 0.04,
                          ),
                          SizedBox(
                            width: width * 0.9,
                            child: Text(
                              isTournamentStarted && isMatchJoined
                                  ? 'Room ID: ${widget.roomid}'
                                  : 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen bookIt was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                              style: TextStyle(
                                color: Color(0xFF545657),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
          ),
          InkWell(
            onTap: widget.matchended
                ? null // Disable button if match ended
                : isTournamentStarted
                    ? null // Disable button if tournament started
                    : isMatchJoined
                        ? null // Disable button if already joined
                        : () {
                            nextScreen(
                              context,
                              JoiningMatch(
                                entryfees: widget.entryfees,
                                game: widget.game,
                                matchid: widget.matchid,
                              ),
                            );
                          },
            child: Container(
              width: width,
              height: height * 0.05,
              color: AppColors.orangecolor,
              child: Center(
                child: widget.matchended
                    ? Text(
                        'MATCH ENDED',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : isTournamentStarted
                        ? Text(
                            'TOURNAMENT STARTED',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : isMatchJoined
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'ALREADY JOINED',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  _buildCountdownTimer(),
                                ],
                              )
                            : Text(
                                'JOIN NOW',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateWallet(String matchid) async {
    String userEmailsDocumentId = checkUserAuthenticationType();
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userEmailsDocumentId);

    DocumentSnapshot userDocSnapshot = await userDocRef.get();
    if (userDocSnapshot.exists) {
      var currentWalletValue = userDocSnapshot['Wallet'] ?? '0';
      int updatedWalletValue =
          int.parse(currentWalletValue) - int.parse(widget.entryfees);

      await userDocRef.update({'Wallet': updatedWalletValue.toString()}).then(
        (value) async {
          await userDocRef.update({
            'matches': FieldValue.arrayUnion([matchid])
          }).then((value) {
            databaseRef = FirebaseDatabase.instance.ref(widget.game);
            databaseRef
                .child(widget.matchid)
                .child('Participants')
                .update({userDocSnapshot['UID']: userDocSnapshot['Email']});
            print('Match ID added successfully');
          });
        },
      );
    }
  }

  Future<void> _checkMatchJoined() async {
    String userEmailsDocumentId = checkUserAuthenticationType();
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userEmailsDocumentId);

    DocumentSnapshot userDocSnapshot = await userDocRef.get();
    if (userDocSnapshot.exists) {
      List<dynamic> matchesJoined = userDocSnapshot['matches'] ?? [];
      isMatchJoined = matchesJoined.contains(widget.matchid);
      setState(() {});
    }
  }

  Future<void> _startCountdown() async {
    try {
      // Ensure the date and time are zero-padded
      List<String> dateParts = widget.date.split('-');
      List<String> timeParts = widget.time.split(':');

      String formattedDate =
          '${dateParts[0]}-${dateParts[1].padLeft(2, '0')}-${dateParts[2].padLeft(2, '0')}';
      String formattedTime =
          '${timeParts[0].padLeft(2, '0')}:${timeParts[1].padLeft(2, '0')}';

      final matchDateTime = DateTime.parse('$formattedDate $formattedTime');
      final currentDateTime = DateTime.now();

      if (matchDateTime.isAfter(currentDateTime)) {
        _remainingTime = matchDateTime.difference(currentDateTime);
        _countdownTimer = Timer.periodic(Duration(seconds: 1), (_) {
          if (mounted) {
            setState(() {
              _remainingTime -= Duration(seconds: 1);
              if (_remainingTime.isNegative) {
                _countdownTimer.cancel();
                isTournamentStarted = true; // Tournament started
              }
            });
          }
        });
      } else {
        isTournamentStarted = true; // Tournament already started
      }
    } catch (e) {
      print('Error parsing date: $e');
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '${hours}:${minutes}:${seconds}';
  }

  Widget _buildCountdownTimer() {
    String countdownText = _formatDuration(_remainingTime);
    return Text(
      countdownText,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void toggleParticipants(int tabid) {
    setState(() {
      if (tabid == 1) {
        textcolor1 = Colors.white;
        textcolor2 = Colors.black;
        showParticipants = !showParticipants;
      }
      if (tabid == 2) {
        textcolor1 = Colors.black;
        textcolor2 = Colors.white;
        showParticipants = !showParticipants;
      }
    });
  }
}
