import 'package:calendar_view/calendar_view.dart';

import 'package:diagenda/bloc/CalendarEvent/CalendarEventBloc.dart';
import 'package:diagenda/bloc/Notes.dart/NotesBloc.dart';
import 'package:diagenda/enumerations.dart';
import 'package:diagenda/model/event.dart';
import 'package:diagenda/pages/Notes_action_page.dart';
import 'package:diagenda/pages/create_event_page.dart';
import 'package:diagenda/widgets/NoteWidget.dart';
import 'package:diagenda/widgets/NotesDialog.dart';
import 'package:diagenda/widgets/eventsDialog.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../app_colors.dart';
import '../extension.dart';

import '../model/Notes.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/events_widget.dart';
import '../widgets/search_box.dart';

class NotesViewPage extends StatefulWidget {
  final bool withDuration;

  const NotesViewPage({Key? key, this.withDuration = false}) : super(key: key);

  @override
  _NotesViewPageState createState() => _NotesViewPageState();
}

class _NotesViewPageState extends State<NotesViewPage>
    with SingleTickerProviderStateMixin {
  int tabIndex = 0;
  List<Notes> notes_lst = [];
  List<CalendarEventData<Event>> events = [];
  late TabController _tabController;
  late SingleValueDropDownController _cnt;
  final List<DropDownValueModel> _sort_options = const [
    DropDownValueModel(name: "Sort by date (oldest first)", value: 0),
    DropDownValueModel(name: "Sort by date (newest first)", value: 1),
  ];
  String sort_val = '';

  @override
  void initState() {
    super.initState();
    _cnt = SingleValueDropDownController();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
    //notes_lst = context.read<NotesRepo>().notes;
  }

  void _handleTabChange() {
    setState(() {
      tabIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _tabController.removeListener(_handleTabChange);
  }

  @override
  Widget build(BuildContext context) {
    //TabController _tabController = TabController(length: 2, vsync: this);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.greenAccent,
        elevation: 8,
        onPressed: () {
          if (_tabController.index == 0) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NoteActionPage(
                  noteAction: NoteAction.add,
                ),
              ),
            );
          }
          if (_tabController.index == 1) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CreateEventPage()),
            );
          }
        },
      ),
      bottomNavigationBar: const BottomNav(),
      //backgroundColor: Colors.blueAccent.withOpacity(0.1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.greenAccent,
        leading: null,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 190,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.blueAccent, Colors.greenAccent],
                          begin: Alignment.bottomLeft,
                          end: Alignment.centerRight),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(80)),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(5, 5),
                            blurRadius: 10,
                            color: Colors.blueAccent)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Text('Hi Rayhaan',
                        //     style: TextStyle(
                        //         fontSize: 22,
                        //         fontWeight: FontWeight.bold,
                        //         color: Colors.white)),
                        // const SizedBox(
                        //   height: 8.0,
                        // ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              child: Image.asset('assets/logo.png'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                DateFormat.yMMMEd()

                                    // displaying formatted date
                                    .format(DateTime.now())
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.82,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(1),
                              child: SearchBox(
                                //  onTextChanged: (text) {},
                                tabIndex: tabIndex,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            sort_drop_down()
                          ],
                        ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              TabBar(
                controller: _tabController,
                labelColor: Colors.blueAccent,
                labelStyle:
                    const TextStyle(fontFamily: 'Poppins', fontSize: 16),
                indicatorColor: Colors.greenAccent,
                tabs: [
                  Tab(
                    text: 'Notes',
                  ),
                  Tab(
                    text: 'Events',
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                  flex: 1,
                  child: TabBarView(
                    controller: _tabController,
                    children: [_notes_list_builder(), _events_list_builder()],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget sort_drop_down() {
    return Container(
        height: 40,
        margin: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: DropDownTextField(
          textFieldDecoration: InputDecoration(
            hintText: 'Sort ',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            fillColor: Colors.white70,
            filled: true,
            contentPadding:
                EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          ),
          clearOption: false,
          dropDownList: _sort_options,
          onChanged: (val) {
            print(val);
            // setState(() {
            //   notes_lst.sort((a, b) => a.timestamp.compareTo(b.timestamp));
            //   //notes_lst = notes_lst.reversed.toList();
            // });
            if (tabIndex == 0) {
              context.read<NotesBloc>().add(SortNotesList(order: val.value));
            } else {
              context
                  .read<CalendarEventBloc>()
                  .add(SortEventList(order: val.value));
            }

            //print(notes_lst);
          },
        ));
  }

  // Widget build_search_field(){

  //   return
  // }
  Widget _events_list_builder() {
    Widget displayWidget;
    return BlocBuilder<CalendarEventBloc, CalendarEventState>(
      builder: (context, state) {
        if (state is CalendarEventLoaded) {
          events = state.events;
        } else if (state is CalendarEventLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CalendarEventAdded) {
          events = state.events;
        }

        if (events.isNotEmpty) {
          displayWidget = ListView.separated(
            scrollDirection: Axis.vertical,
            itemCount: events.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: EventWidget(event: events[index]),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EventDialog(event: events[index]);
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
        } else {
          displayWidget = const Center(child: Text('No events to display'));
        }
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.greenAccent.withOpacity(0.3),
          ),
          padding: const EdgeInsets.all(10.0),
          height: MediaQuery.of(context).size.height,
          child: displayWidget,
        );
      },
    );
  }

  Widget _notes_list_builder() {
    Widget displayWidget;
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        if (state is NotesLoaded) {
          notes_lst = state.notes;
        } else if (state is NotesLoading) {
          context.read<NotesBloc>().add(const LoadNotes());
          return const Center(child: CircularProgressIndicator());
        }

        if (notes_lst.isNotEmpty) {
          displayWidget = ListView.separated(
            scrollDirection: Axis.vertical,
            itemCount: notes_lst.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: NotesWidget(note: notes_lst[index]),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return NotesDialog(note: notes_lst[index]);
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
        } else {
          displayWidget = const Center(child: Text('No notes to display'));
        }
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.greenAccent.withOpacity(0.3),
          ),
          padding: const EdgeInsets.all(10.0),
          height: MediaQuery.of(context).size.height,
          child: displayWidget,
        );
      },
    );
  }
}
