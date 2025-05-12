import 'package:flutter/material.dart';
import 'numbers_screen.dart';
import 'alphabets_screen.dart';

class PracticeScreen extends StatelessWidget {
  PracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80), // Increased height
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.blueGrey,
            automaticallyImplyLeading: false,
            flexibleSpace: const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TabBar(
                  indicatorColor: Colors.lightBlueAccent,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  tabs: [
                    Tab(
                        text: "Numbers",
                        icon: Icon(Icons.format_list_numbered)),
                    Tab(text: "Alphabets", icon: Icon(Icons.abc)),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            NumbersScreen(),
            AlphabetsScreen(),
          ],
        ),
      ),
    );
  }
}
