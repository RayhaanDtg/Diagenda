import 'package:calendar_view/calendar_view.dart';
import 'package:diagenda/bloc/CalendarEvent/CalendarEventBloc.dart';
import 'package:diagenda/enumerations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

import '../app_colors.dart';
import '../constants.dart';
import '../extension.dart';
import '../model/event.dart';
import 'custom_button.dart';
import 'date_time_selector.dart';

class AddEventWidget extends StatefulWidget {
  // final EventController<CalendarEventData> controller;

  const AddEventWidget({
    Key? key,
    // required this.controller,
  }) : super(key: key);

  @override
  _AddEventWidgetState createState() => _AddEventWidgetState();
}

class _AddEventWidgetState extends State<AddEventWidget> {
  late DateTime _startDate;
  late DateTime _endDate;
  ImportanceLevel _importanceLevel = ImportanceLevel.Low;
  bool _toggleValue = false;
  DateTime? _startTime;

  DateTime? _endTime;
  DateTime? _endTimeTemp;
  DateTime? _startTimeTemp;

  String _title = "";

  String _description = "";

  Color _color = ImportanceLevel.Low.importanceColor as Color;

  late FocusNode _titleNode;

  late FocusNode _descriptionNode;

  late FocusNode _dateNode;

  final GlobalKey<FormState> _form = GlobalKey();

  late TextEditingController _startDateController;
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;
  late TextEditingController _endDateController;

  @override
  void initState() {
    super.initState();

    _titleNode = FocusNode();
    _descriptionNode = FocusNode();
    _dateNode = FocusNode();

    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
    _startTimeController = TextEditingController();
    _endTimeController = TextEditingController();
  }

  @override
  void dispose() {
    _titleNode.dispose();
    _descriptionNode.dispose();
    _dateNode.dispose();

    _startDateController.dispose();
    _endDateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Container(
        //padding: EdgeInsets.all(value),
        child: ListView(
          //
          //
          //  mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: AppConstants.inputDecoration.copyWith(
                  //labelText: "Event Title",
                  //hintText: "fuck Title",
                  ),
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 17.0,
              ),
              onSaved: (value) => _title = value?.trim() ?? "",
              validator: (value) {
                if (value == null || value == "") {
                  return "Please enter event title.";
                }

                return null;
              },
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: DateTimeSelectorFormField(
                    controller: _startDateController,
                    decoration: AppConstants.inputDecoration.copyWith(
                      labelText: "Start Date",
                    ),
                    validator: (value) {
                      if (value == null || value == "")
                        return "Please select date.";

                      return null;
                    },
                    textStyle: const TextStyle(
                      color: AppColors.black,
                      fontSize: 17.0,
                    ),
                    onSave: (date) => _startDate = date,
                    type: DateTimeSelectionType.date,
                  ),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: DateTimeSelectorFormField(
                    controller: _endDateController,
                    decoration: AppConstants.inputDecoration.copyWith(
                      labelText: "End Date",
                    ),
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please select date.";
                      }

                      return null;
                    },
                    textStyle: const TextStyle(
                      color: AppColors.black,
                      fontSize: 17.0,
                    ),
                    onSave: (date) => _endDate = date,
                    type: DateTimeSelectionType.date,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: DateTimeSelectorFormField(
                    controller: _startTimeController,
                    decoration: AppConstants.inputDecoration.copyWith(
                      labelText: "Start Time",
                    ),
                    validator: (value) {
                      if (value == null || value == "")
                        return "Please select start time.";

                      return null;
                    },
                    onSave: (date) => _startTime = date,
                    onSelect: (p0) {
                      _startTimeTemp = p0;
                    },
                    textStyle: const TextStyle(
                      color: AppColors.black,
                      fontSize: 17.0,
                    ),
                    type: DateTimeSelectionType.time,
                  ),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: DateTimeSelectorFormField(
                    controller: _endTimeController,
                    decoration: AppConstants.inputDecoration.copyWith(
                      labelText: "End Time",
                    ),
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please select end time.";
                      } else if (_endTimeTemp!
                          .isBefore(_startTimeTemp as DateTime)) {
                        return " End time should be at least 30 mins greater than start time.";
                      }

                      return null;
                    },
                    onSave: (date) => _endTime = date,
                    onSelect: (p0) {
                      _endTimeTemp = p0;
                    },
                    textStyle: const TextStyle(
                      color: AppColors.black,
                      fontSize: 17.0,
                    ),
                    type: DateTimeSelectionType.time,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              focusNode: _descriptionNode,
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 17.0,
              ),
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              selectionControls: MaterialTextSelectionControls(),
              minLines: 1,
              maxLines: 10,
              maxLength: 1000,
              validator: (value) {
                if (value == null || value.trim() == "")
                  return "Please enter event description.";

                return null;
              },
              onSaved: (value) => _description = value?.trim() ?? "",
              decoration: AppConstants.inputDecoration.copyWith(
                hintText: "Event Description",
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Importance: ",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                _buildDropDown(),
                SizedBox(
                  width: 10.0,
                ),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: _importanceLevel.importanceColor,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Set Reminder: ",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      "(30 mins before event) ",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10.0,
                ),
                // SizedBox(
                //   width: 10.0,
                // ),
                Switch(
                  value: _toggleValue,
                  onChanged: (bool value) {
                    setState(() {
                      _toggleValue = value;
                      print(
                          'here we are checking the toggle switch----------------');
                      print(_toggleValue);
                    });
                  },
                  activeColor: Colors.blueAccent.withOpacity(0.4),
                ),
              ],
            ),
            // _buildDropDown(),
            const SizedBox(
              height: 45,
            ),
            BlocBuilder<CalendarEventBloc, CalendarEventState>(
              builder: (context, state) {
                return CustomButton(
                  onTap: () {
                    var result = _createEvent();
                    if (result) {
                      _resetForm();
                      Navigator.of(context).pop();
                    }
                  },
                  title: "Add Event",
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  bool _createEvent() {
    // if (!(_form.currentState?.validate() ?? true)) return;

    if (_form.currentState!.validate()) {
      _form.currentState?.save();

      Event miniEvent = Event(
          title: _title,
          importanceLevel: _importanceLevel,
          notification: _toggleValue);
      final event = CalendarEventData<Event>(
        date: _startDate,
        color: _importanceLevel.importanceColor as Color,
        endTime: _endTime,
        startTime: _startTime,
        description: _description,
        endDate: _endDate,
        title: _title,
        event: miniEvent,
      );

      print('---------------here idk what to do anymore print----------------');
      print(miniEvent);
      context.read<CalendarEventBloc>().add(AddCalendarEvent(event: event));
      // widget.onEventAdd?.call(event);

      return true;
    }
    print(
        'fuuuuuuuuck meeeeeee!!!!!!111----------------------------------------------------------');
    return false;
  }

  void _resetForm() {
    _form.currentState?.reset();
    _startDateController.text = "";
    _endTimeController.text = "";
    _startTimeController.text = "";
  }

  Widget _buildDropDown() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton<ImportanceLevel>(
          value: _importanceLevel,
          onChanged: (ImportanceLevel? newValue) {
            setState(() {
              _importanceLevel = newValue!;
            });
          },
          items: ImportanceLevel.values.map((ImportanceLevel importanceLevel) {
            return DropdownMenuItem<ImportanceLevel>(
                value: importanceLevel,
                child: Text(
                  importanceLevel.name.toString(),
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 17,
                  ),
                ));
          }).toList()),
    );
  }

  // void _displayColorPicker() {
  //   var color = _color;
  //   showDialog(
  //     context: context,
  //     useSafeArea: true,
  //     barrierColor: Colors.black26,
  //     builder: (_) => SimpleDialog(
  //       clipBehavior: Clip.hardEdge,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(30.0),
  //         side: const BorderSide(
  //           color: AppColors.bluishGrey,
  //           width: 2,
  //         ),
  //       ),
  //       contentPadding: const EdgeInsets.all(20.0),
  //       children: [
  //         const Text(
  //           "Event Color",
  //           style: TextStyle(
  //             color: AppColors.black,
  //             fontSize: 25.0,
  //           ),
  //         ),
  //         Container(
  //           margin: const EdgeInsets.symmetric(vertical: 20.0),
  //           height: 1.0,
  //           color: AppColors.bluishGrey,
  //         ),
  //         ColorPicker(
  //           displayThumbColor: true,
  //           enableAlpha: false,
  //           pickerColor: _color,
  //           onColorChanged: (c) {
  //             color = c;
  //           },
  //         ),
  //         Center(
  //           child: Padding(
  //             padding: const EdgeInsets.only(top: 50.0, bottom: 30.0),
  //             child: CustomButton(
  //               title: "Select",
  //               onTap: () {
  //                 if (mounted)
  //                   setState(() {
  //                     _color = color;
  //                   });
  //                 context.pop();
  //               },
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
