import 'package:diagenda/bloc/Notes.dart/NotesBloc.dart';
import 'package:diagenda/widgets/attachment_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../enumerations.dart';
import '../model/Notes.dart';
import '../pages/Notes_action_page.dart';

class NotesDialog extends StatelessWidget {
  const NotesDialog({
    Key? key,
    required this.note,
  }) : super(key: key);

  final Notes note;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 40,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              DateFormat.yMMMEd()

                  // displaying formatted date
                  .format(note.timestamp)
                  .toString(),
              style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            width: 300,
            constraints: BoxConstraints(minHeight: 250),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.blueAccent.withOpacity(0.3),
              // shape: BoxShape.circle
            ),
            child: Text(note.description),
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Attachments: ',
                style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Divider(
            height: 2.0,
            thickness: 2.0,
          ),
          Material(
            child: Container(
              padding: EdgeInsets.all(5.0),
              // height: 200,
              color: Colors.blueAccent.withOpacity(0.3),
              child: note.attachments != null
                  ? GridViewAttachments(files: note.attachments)
                  : Container(),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NoteActionPage(
                  noteAction: NoteAction.edit,
                  note: note,
                ),
              ),
            );
          },
          child: const Text('Edit Note'),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<NotesBloc>().add(DeleteNote(note: note));
            Navigator.of(context).pop();
          },
          child: const Text('Delete Note'),
        ),
      ],
    );
  }
}
