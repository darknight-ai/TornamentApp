import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oneup_noobs/Pages/Wallet/components/wallettext.dart';
import 'package:oneup_noobs/Pages/Wallet/mywallet.dart';
import 'package:oneup_noobs/Pages/Wallet/userauthenticationtype.dart';
import 'package:oneup_noobs/Pages/tournament_page.dart';
import 'package:oneup_noobs/Services/database_Services.dart';
import 'package:oneup_noobs/Utils/colors.dart';
import 'package:oneup_noobs/Utils/widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final fireStore2 =
      FirebaseFirestore.instance.collection('Banners').snapshots();
  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();
  late Stream<QuerySnapshot> games;
  Color tabcolor1 = AppColors.bluecolor;
  Color tabcolor2 = Colors.white;
  Color textcolor1 = Colors.white;
  Color textcolor2 = Colors.black;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    games = DatabaseService().getGamesStream();
  }

  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    final double height = screensize.height;
    final double width = screensize.width;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.bluecolor,
          title: Row(
            children: [
              Text(
                'One Noobs App',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  nextScreen(context, Wallet());
                },
                child: Container(
                  width: width * 0.300,
                  height: height * 0.039,
                  decoration: ShapeDecoration(
                    color: Color(0xFEFCFDFB),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFF96D2EB)),
                      borderRadius: BorderRadius.circular(6.50),
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
                          Spacer(),
                          FutureBuilder<String>(
                            future: _walletbalance(),
                            builder: (context, snapshot) {
                              return Text(
                                '${snapshot.data}',
                                style: TextStyle(
                                  color: Color(0xFF494B4D),
                                  fontSize: 20,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w900,
                                  height: 0,
                                ),
                              );

                              // if (snapshot.connectionState ==
                              //     ConnectionState.waiting) {
                              //   return Wallettext(
                              //     title: 'Loading...',
                              //   );
                              // } else if (snapshot.hasError) {
                              //   return Wallettext(
                              //     title: 'Error',
                              //   );
                              // } else {
                              //   return Text(
                              //     '🪙 ${snapshot.data}',
                              //     style: TextStyle(
                              //       color: Color(0xFF494B4D),
                              //       fontSize: 25,
                              //       fontFamily: 'Inter',
                              //       fontWeight: FontWeight.w400,
                              //       height: 0,
                              //     ),
                              //   );
                              //   // Wallettext(
                              //   //   title: '🪙${snapshot.data}',
                              //   // );
                              // }
                            },
                          ),
                          Spacer(),
                        ]),
                    // Text(
                    //   '🪙 0.00',
                    //   style: TextStyle(
                    //     color: Color(0xFF494B4D),
                    //     fontSize: 25,
                    //     fontFamily: 'Inter',
                    //     fontWeight: FontWeight.w400,
                    //     height: 0,
                    //   ),
                    // ),
                  ),
                ),
              )
            ],
          ),
        ),
        body: Column(children: [
          Column(children: [
            StreamBuilder<QuerySnapshot>(
              stream: fireStore2, // Use the stream variable
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text('No banners found.');
                }

                // Rest of the CarouselSlider code...

                // Now, integrate the _buildCarouselDots method
                return Column(
                  children: [
                    SizedBox(
                      height: height * 0.02,
                    ),
                    CarouselSlider(
                      carouselController: _controller,
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.95,
                        aspectRatio: 2.2,
                        initialPage: 2,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                      items: snapshot.data!.docs.map((document) {
                        // Map the snapshot documents to carousel items
                        String imageUrl = document['Course Img Link'];
                        // Assuming this is how your data is structured
                        // Build your carousel item with the image URL
                        String bannerfunction = document['Banner Function'];
                        String bannertype = document['Banner Type'];
                        return Builder(
                          builder: (BuildContext context) {
                            return InkWell(
                              onTap: () {
                                // if (bannertype == 'External Link') {
                                //   _launchURL(bannerfunction);
                                // } else if (bannertype ==
                                //     'Course Function') {
                                //   fetchData(bannerfunction);
                                // } else if (bannertype == 'Nothing') {}
                              },
                              child: Container(
                                height: 10,
                                width: 500,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(), // Make sure to convert the map result to a list

                      // Existing CarouselSlider code...
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   // Call the modified _buildCarouselDots with the length of the snapshot documents
                    //   children:
                    //       _buildCarouselDots(snapshot.data!.docs.length),
                    // ),
                  ],
                );
              },
            ),
          ]),
          SizedBox(
            height: height * 0.03,
          ),
          Container(
            width: width * 0.922,
            height: height * 0.05,
            decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 206, 206, 206)),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _tabbar(1);
                  },
                  child: Container(
                    width: width * 0.457,
                    height: height * 0.05,
                    decoration: ShapeDecoration(
                      color: tabcolor1,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: tabcolor1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'TOURNAMENT',
                        style: TextStyle(
                            color: textcolor1,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _tabbar(2);
                  },
                  child: Container(
                    width: width * 0.457,
                    height: height * 0.05,
                    decoration: ShapeDecoration(
                      color: tabcolor2,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: tabcolor2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'SOLO',
                        style: TextStyle(
                            color: textcolor2,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Expanded(child: notificationFetcher())
        ]));
  }

  Widget notificationFetcher() {
    final Size screensize = MediaQuery.of(context).size;
    final double height = screensize.height;
    final double width = screensize.width;
    if (tabcolor2 == AppColors.bluecolor) {
      // Return a blank GridView
      // return GridView.builder(
      //   padding: EdgeInsets.all(width * 0.04),
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 3,
      //     crossAxisSpacing: width * 0.03,
      //     mainAxisSpacing: height * 0.015,
      //   ),
      //   itemCount: 0, // Set itemCount to 0 to show a blank GridView
      //   itemBuilder: (context, index) {
      return Container(
        child: Text('Coming soon...'),
      ); // Return an empty Container
    }
    return StreamBuilder(
      stream: games,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          // Sort the list of notifications based on timestamp
          // Assuming 'id' is the timestamp

          return GridView.builder(
            padding: EdgeInsets.all(width * 0.04),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Number of items per row
              crossAxisSpacing:
                  width * 0.03, // Space between items horizontally
              mainAxisSpacing: height * 0.015, // Space between items vertically
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              // Returning each item for the grid
              return InkWell(
                onTap: () async {
                  String walletBalance = await _walletbalance();
                  nextScreen(
                      context,
                      TournamentPage(
                        walletbalance: walletBalance,
                        gamename:
                            snapshot.data!.docs[index]['GameName'].toString(),
                      ));
                },
                child: Container(
                  width: width * 0.3, // Adjust the width as needed
                  height: width * 0.3,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          snapshot.data!.docs[index]['GameImg'].toString()),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.50),
                        topRight: Radius.circular(9.75),
                        bottomLeft: Radius.circular(13.50),
                        bottomRight: Radius.circular(9.75),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  Future<String> _walletbalance() async {
    String userEmailsDocumentId = checkUserAuthenticationType();
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userEmailsDocumentId);

    DocumentSnapshot userDocSnapshot = await userDocRef.get();
    if (userDocSnapshot.exists) {
      var currentWalletValue = userDocSnapshot['Wallet'] ?? '0';
      return currentWalletValue.toString();
    } else {
      return '0';
    }
  }

  void _tabbar(int tabnumber) {
    setState(() {
      if (tabnumber == 1) {
        tabcolor1 = AppColors.bluecolor;
        tabcolor2 = Colors.white;
        textcolor1 = Colors.white;
        textcolor2 = Colors.black;
      }
      if (tabnumber == 2) {
        tabcolor1 = Colors.white;
        tabcolor2 = AppColors.bluecolor;
        textcolor1 = Colors.black;
        textcolor2 = Colors.white;
      }
    });
  }
}
