import 'package:diagenda/model/Notes.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotesWidget extends StatefulWidget {
  Notes note;
  NotesWidget({Key? key, required this.note}) : super(key: key);

  @override
  _NotesWidgetState createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
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
    return Container(
      //height: 210,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.note.title,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Text(
                DateFormat.yMMMEd()

                    // displaying formatted date
                    .format(widget.note.timestamp)
                    .toString(),
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                )),
            padding: EdgeInsets.only(left: 10.0, bottom: 5.0, top: 5.0),
            constraints: BoxConstraints(minHeight: 50),
            // height: 50,

            child: Row(
              children: [
                Flexible(
                  child: Text(
                    widget.note.description,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w200),
                  ),
                )
              ],
            ),
          ),
          //SizedBox(height: 15.0),
          _build_attachements()
        ],
      ),
    );
  }

  Widget _build_attachements() {
    if (widget.note.attachments.isNotEmpty) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.3),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5.0),
              bottomRight: Radius.circular(5.0),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.attach_file_outlined,
                size: 18.0,
              ),
            ),
            Text('Attachments present')
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
