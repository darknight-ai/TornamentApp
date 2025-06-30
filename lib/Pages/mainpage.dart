import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oneup_noobs/Admin/addmatches.dart';
import 'package:oneup_noobs/Pages/Account/accountpage.dart';
import 'package:oneup_noobs/Pages/ReferalSystem/referandearn.dart';
import 'package:oneup_noobs/Pages/homepage.dart';
import 'package:oneup_noobs/Pages/tournament_page.dart';
import 'package:oneup_noobs/Utils/colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PageController _pageController;
  int _currentIndex = 1; // Set default index to 1 (Play)
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: _currentIndex); // Set initial page to the default index
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    final double height = screensize.height;
    final double width = screensize.width;
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return false;
        } else {
          if (currentBackPressTime == null ||
              DateTime.now().difference(currentBackPressTime!) >
                  Duration(seconds: 2)) {
            currentBackPressTime = DateTime.now();
            // MySnackbar.show(context, 'Press Back Again to exit');

            return false;
          }
          exit(0);
        }
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            ReferEarn(),
            HomePage(),
            // TournamentPage(
            //   gamename: 'gamename',
            //   walletbalance: "100",
            // )
            AccountPage()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.bluecolor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Color.fromARGB(255, 53, 42, 48),
          showUnselectedLabels: true,
          currentIndex: _currentIndex,
          onTap: (index) {
            // Change the tab when a bottom navigation item is tapped
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                color: Colors.amber,
                Icons.monetization_on,
              ),
              label: 'Refer Us',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.games,
              ),
              label: 'Play',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Account',
            ),
            // BottomNavigationBarItem(
            //   icon: Image.asset(
            //     'assets/icons/gramsetuicon.png',
            //     scale: 15,
            //   ),
            //   label: 'Gram Setu',
            // ),
            // BottomNavigationBarItem(
            //   icon: Image.asset(
            //     'assets/icons/bhatnericon.png',
            //     scale: 8,
            //   ),
            //   label: 'Bhatner Post',
            // ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     Icons.book,
            //   ),
            //   label: 'Web Stories',
            // ),
          ],
        ),
      ),
    );
  }

  // Future<void> _launchURL(String urlString) async {
  //   final Uri url = Uri.parse(urlString);
  //   if (!await launchUrl(url)) {
  //     throw 'Could not launch $urlString';
  //   }
  // }
}
