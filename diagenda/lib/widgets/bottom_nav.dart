import 'package:flutter/material.dart';

import '../pages/Notes_action_page.dart';
import '../pages/calendar_view.dart';
import '../pages/notes_view_page.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5.0),
          topRight: Radius.circular(5.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NotesViewPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.book_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CalendarViewPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.calendar_month_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
