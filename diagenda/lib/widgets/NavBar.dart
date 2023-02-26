import 'package:diagenda/Notification.dart';
import 'package:diagenda/widgets/day_view_widget.dart';
import 'package:diagenda/widgets/month_view_widget.dart';
import 'package:diagenda/widgets/week_view_widget.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget implements PreferredSizeWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(75);
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            //padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            // color: Colors.orangeAccent,
            child: AppBar(
              backgroundColor: Colors.greenAccent,
              leading: Builder(
                builder: (context) {
                  return Container();
                },
              ),
              actions: [
                PopupMenuButton<int>(onSelected: (value) {
                  if (value == 0) {
                    print('fuck');
                    MonthViewNotification(MonthViewWidget()).dispatch(context);
                  } else if (value == 1) {
                    WeekViewNotification(WeekViewWidget()).dispatch(context);
                  } else {
                    DayViewNotification(DayViewWidget()).dispatch(context);
                  }
                }, itemBuilder: ((context) {
                  return [
                    PopupMenuItem<int>(child: Text('Month View'), value: 0),
                    PopupMenuItem<int>(child: Text('Week View'), value: 1),
                    PopupMenuItem<int>(child: Text('Day View'), value: 2),
                  ];
                }))
              ],
            ),
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     IconButton(
          //         onPressed: () {
          //           Scaffold.of(context).openDrawer();
          //         },
          //         icon: const Icon(Icons.stacked_bar_chart,
          //             color: Colors.black, size: 25.0)),
          //   ],
          // ),
          // Container(
          //     width: 700,
          //     color: Colors.amberAccent,
          //     padding: EdgeInsets.all(3.0),
          //     height: 100,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         Container(
          //           height: 35,
          //           width: 300,
          //           margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(8.0),
          //             boxShadow: [
          //               BoxShadow(
          //                 // blurRadius: 4,
          //                 color: Colors.greenAccent.withOpacity(0.3),
          //                 // offset: const Offset(0, 5),
          //               )
          //             ],
          //             // color: Colors.black45,
          //           ),
          //           child: TextField(
          //             decoration: InputDecoration(
          //                 suffixIcon: Icon(Icons.search),
          //                 // border: OutlineInputBorder(
          //                 //   borderRadius: BorderRadius.circular(4.0),
          //                 // ),
          //                 fillColor: Colors.white70,
          //                 border: OutlineInputBorder(
          //                   borderRadius: BorderRadius.circular(8.0),
          //                 ),
          //                 filled: true,
          //                 contentPadding: EdgeInsets.only(
          //                     bottom: 10.0, left: 10.0, right: 10.0),
          //                 labelText: 'Search '),
          //           ),
          //         ),
          //       ],
          //     )),
        ],
      ),
    );
  }
}
