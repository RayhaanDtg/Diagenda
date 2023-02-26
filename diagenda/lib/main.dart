import 'dart:ui';

import 'package:diagenda/Repo/EventsRepository.dart';

import 'package:diagenda/Repo/NotesRepository.dart';
import 'package:diagenda/bloc/CalendarEvent/CalendarEventBloc.dart';
import 'package:diagenda/bloc/Notes.dart/NotesBloc.dart';
import 'package:diagenda/pages/calendar_view.dart';
import 'package:diagenda/pages/splashscreen.dart';
import 'package:diagenda/services/NotesService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:hive/hive.dart';
import 'services/NotificationServices.dart';

import 'services/CalendarEventService.dart';

DateTime get _now => DateTime.now();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await NotificationService.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // NotesRepository notesRepo = NotesRepository(hiveService: NotesHiveService());
  // EventsRepository eventsRepo =
  //     EventsRepository(hiveService: CalendarEventService());

  @override
  Widget build(BuildContext context) {
    // notesHiveService.init();
    // eventsHiveService.init();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => NotesRepository(hiveService: NotesHiveService()),
        ),
        RepositoryProvider(
          create: (context) =>
              EventsRepository(hiveService: CalendarEventService()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                NotesBloc(notesRepo: context.read<NotesRepository>())
                  ..add(const RegisterNoteService()),
          ),
          BlocProvider(
            create: (context) => CalendarEventBloc(
                eventsRepository: context.read<EventsRepository>())
              ..add(const RegisterCalendarService()),
          ),
        ],
        child: MaterialApp(
            title: 'Diagenda',
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            scrollBehavior: ScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.trackpad,
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
              },
            ),
            home: SplashScreen()),
      ),
    );
    // return CalendarControllerProvider<Event>(
    //   controller: EventController<Event>()..addAll(EventList().events),
    //   child: BlocProvider(
    //     create: (_) => CalendarEventBloc(),
    //     child: MaterialApp(
    //       title: 'Flutter Calendar Page Demo',
    //       debugShowCheckedModeBanner: false,
    //       theme: ThemeData.light(),
    //       scrollBehavior: ScrollBehavior().copyWith(
    //         dragDevices: {
    //           PointerDeviceKind.trackpad,
    //           PointerDeviceKind.mouse,
    //           PointerDeviceKind.touch,
    //         },
    //       ),
    //       home: ResponsiveWidget(
    //         mobileWidget: MobileHomePage(),
    //       ),
    //     ),
    //   ),
    // );
  }
}
