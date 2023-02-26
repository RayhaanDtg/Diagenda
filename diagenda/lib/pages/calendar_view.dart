import 'package:diagenda/Repo/NotesRepository.dart';
import 'package:diagenda/bloc/CalendarEvent/CalendarEventBloc.dart';
import 'package:diagenda/bloc/Notes.dart/NotesBloc.dart';
import 'package:diagenda/widgets/day_view_widget.dart';
import 'package:diagenda/widgets/week_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../NotesDisplayNotfication.dart';

import '../app_colors.dart';
import '../extension.dart';
import '../model/Notes.dart';

import '../widgets/NotesViewDialog.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/month_view_widget.dart';
import 'create_event_page.dart';

class CalendarViewPage extends StatefulWidget {
  const CalendarViewPage({
    Key? key,
  }) : super(key: key);

  @override
  _CalendarViewPageState createState() => _CalendarViewPageState();
}

class _CalendarViewPageState extends State<CalendarViewPage> {
  Widget widet_to_display = MonthViewWidget();
  List<Notes> note_lst = [];
  DateTime displayDate = DateTime.now();

  // @override
  // void initState() {
  //   note_lst = context.read<NotesRepository>().getNotesbyDate(DateTime.now());
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<NotesDisplayNotificiation>(
      onNotification: (notification) {
        print('bro we are here');
        setState(() {
          displayDate =
              notification.date; // widet_to_display = notification.widget;
          note_lst =
              context.read<NotesRepository>().getNotesbyDate(notification.date);
          print(notification.date);
          print(note_lst.length);
        });
        return true;
      },
      child: Scaffold(
        //backgroundColor: Colors.greenAccent.withOpacity(1.1),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.greenAccent,
          centerTitle: false,
          leading: null,
        ),
        bottomNavigationBar: const BottomNav(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.greenAccent,
          elevation: 8,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CreateEventPage(),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
        body: SafeArea(
          child: Container(
              //padding: EdgeInsets.all(5.0),
              height: MediaQuery.of(context).size.height,
              color: Colors.greenAccent.withOpacity(0.3),
              child: ListView(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildViewButtons('Month View'),
                        _buildViewButtons('Week View'),
                        _buildViewButtons('Day View'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  BlocConsumer<CalendarEventBloc, CalendarEventState>(
                      listener: (context, state) {
                    if (state is CalendarEventLoading) {
                      context
                          .read<CalendarEventBloc>()
                          .add(const LoadCalendarEvent());
                    }
                  }, builder: (context, state) {
                    if (state is CalendarEventLoading) {
                      // context
                      //     .read<CalendarEventBloc>()
                      //     .add(const LoadCalendarEvent());
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CalendarEventLoaded) {
                      return widet_to_display;
                    } else if (state is CalendarEventAdded) {
                      return widet_to_display;
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Notes for '),
                      Text(
                        DateFormat.MMMMEEEEd()

                            // displaying formatted date
                            .format(displayDate)
                            .toString(),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.all(10.0),
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.blueAccent.withOpacity(0.1),
                          ),
                          child: _buildNotesList()),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget _buildNotesList() {
    return BlocConsumer<NotesBloc, NotesState>(
      builder: (context, state) {
        if (state is NotesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NotesLoaded) {
          if (note_lst.isEmpty) {
            return const Center(child: Text('No Notes to display'));
          } else {
            return ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: note_lst.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Container(
                    height: 75.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.amberAccent.withOpacity(0.5),
                    ),
                    child: Center(child: Text(note_lst[index].title)),
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NotesViewDialog(note: note_lst[index]);
                        });
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 5.0,
                );
              },
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
      listener: (context, state) {
        if (state is NotesLoading) {
          context.read<NotesBloc>().add(const LoadNotes());
        }
        if (state is NotesLoaded) {
          setState(() {
            note_lst =
                context.read<NotesRepository>().getNotesbyDate(DateTime.now());
          });
        }
      },
    );
  }

  Widget _buildViewButtons(String type) {
    Widget widgetTemp;

    switch (type) {
      case 'Month View':
        {
          widgetTemp = MonthViewWidget();
        }
        break;
      case 'Week View':
        {
          widgetTemp = WeekViewWidget();
        }
        break;
      case 'Day View':
        {
          widgetTemp = DayViewWidget();
        }
        break;
      default:
        {
          widgetTemp = MonthViewWidget();
        }
        break;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          note_lst =
              context.read<NotesRepository>().getNotesbyDate(DateTime.now());
          widet_to_display = widgetTemp;
        });
      },
      child: Container(
          padding: const EdgeInsets.all(5.0),
          height: 30,
          width: 80,
          decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10.0)),
          child: Center(
            child: Text(
              type,
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
            ),
          )),
    );
  }
}
