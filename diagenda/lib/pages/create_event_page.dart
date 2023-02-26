import 'package:calendar_view/calendar_view.dart';
import 'package:diagenda/model/event.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../extension.dart';
import '../widgets/add_event_widget.dart';

class CreateEventPage extends StatefulWidget {
  final bool withDuration;

  const CreateEventPage({Key? key, this.withDuration = false})
      : super(key: key);

  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.greenAccent,
        centerTitle: false,
        leading: null,
        title: const Text(
          "Create New Event",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.greenAccent.withOpacity(0.3),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: AddEventWidget(),
        ),
      ),
    );
  }
}
