import 'package:flutter/material.dart';
import 'package:oneup_noobs/Utils/colors.dart';

class AddKills extends StatefulWidget {
  const AddKills({super.key});

  @override
  State<AddKills> createState() => _AddKillsState();
}

class _AddKillsState extends State<AddKills> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bluecolor,
      ),
    );
  }
}
