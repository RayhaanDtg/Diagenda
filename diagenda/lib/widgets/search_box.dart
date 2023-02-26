import 'package:diagenda/bloc/CalendarEvent/CalendarEventBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Notes.dart/NotesBloc.dart';

class SearchBox extends StatefulWidget {
//  final Function(String) onTextChanged;
  final int tabIndex;

  const SearchBox({Key? key, required this.tabIndex}) : super(key: key);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  TextEditingController _textEditingController = TextEditingController();
  late FocusNode focusNode;
  bool isClear = true;
  String _hintText = 'Search';

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Widget build_button() {
    if (isClear) {
      return IconButton(
        onPressed: () {
          setState(() {
            _hintText = _textEditingController.text;
            isClear = false;
            focusNode.unfocus();
          });
          if (widget.tabIndex == 0) {
            context
                .read<NotesBloc>()
                .add(SearchNote(query: _textEditingController.text));
          } else {
            context
                .read<CalendarEventBloc>()
                .add(SearchEvent(query: _textEditingController.text));
          }
        },
        icon: const Icon(Icons.search),
      );
    } else {
      return IconButton(
        onPressed: () {
          _textEditingController.clear();
          // widget.onTextChanged('');
          focusNode.unfocus();
          setState(() {
            isClear = true;
          });
          if (widget.tabIndex == 0) {
            context.read<NotesBloc>().add(const LoadNotes());
          } else {
            context.read<CalendarEventBloc>().add(const LoadCalendarEvent());
          }
        },
        icon: const Icon(Icons.clear),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            focusNode: focusNode,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: _textEditingController,
            decoration: InputDecoration(
              suffixIcon: build_button(),
              hintText: 'Search',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide:
                      const BorderSide(color: Colors.white, width: 0.0)),
              fillColor: Colors.white70,
              filled: true,
              contentPadding:
                  const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
            ),
            // onChanged: (text) {
            //   widget.onTextChanged(text);
            // },
          ),
        ),
      ],
    );
  }
}
