import 'dart:io';

import 'package:diagenda/widgets/attachment_grid_view.dart';
import 'package:diagenda/widgets/custom_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../app_colors.dart';
import '../bloc/Notes.dart/NotesBloc.dart';
import '../constants.dart';
import '../extension.dart';
import '../enumerations.dart';
import '../model/Notes.dart';

import '../widgets/bottom_nav.dart';

class NoteActionPage extends StatefulWidget {
  final bool withDuration;
  final Enum noteAction;
  Notes? note;

  NoteActionPage({
    Key? key,
    this.withDuration = false,
    this.note,
    required this.noteAction,
  }) : super(key: key);

  @override
  _NoteActionPageState createState() => _NoteActionPageState();
}

class _NoteActionPageState extends State<NoteActionPage> {
  List<String> chosenFiles = [];
  File? chosen_image;
  DateTime _startDate = DateTime.now();

  String _title = "";

  String _description = "";

  late FocusNode _titleNode;

  late FocusNode _descriptionNode;

  late FocusNode _dateNode;

  final GlobalKey<FormState> _form = GlobalKey();

  TextEditingController _startDateController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleNode = FocusNode();
    _descriptionNode = FocusNode();
    _dateNode = FocusNode();
    if (widget.note != null) {
      _title = widget.note!.title;
      _description = widget.note!.description;

      _startDate = widget.note!.timestamp;
      chosenFiles = widget.note!.attachments;
    }

    _startDateController.text =
        DateFormat.yMMMEd().format(_startDate).toString();
    _titleController.text = _title;
    _descriptionController.text = _description;
  }

  @override
  void dispose() {
    _titleNode.dispose();
    _descriptionNode.dispose();
    _dateNode.dispose();

    _startDateController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.greenAccent,
        centerTitle: false,
        leading: IconButton(
          onPressed: context.pop,
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
        ),
        title: Text(
          widget.noteAction.name.toString(),
          style: TextStyle(
            color: AppColors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(padding: EdgeInsets.all(20.0), child: build_note_widget()),
    );
  }

  Widget build_note_widget() {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        return Form(
          key: _form,
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      Text(
                        _startDateController.text,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 17,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), //get today's date
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            String formattedDate = DateFormat.yMMMEd()

                                // displaying formatted date
                                .format(pickedDate)
                                .toString();
                            setState(() {
                              _startDate = pickedDate;
                              _startDateController.text = formattedDate;
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.calendar_month,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                    ],
                  )),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _titleController,
                decoration: AppConstants.inputDecoration.copyWith(
                  labelText: "Note Title",
                ),
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 17.0,
                ),
                onSaved: (value) => _title = value?.trim() ?? "",
                validator: (value) {
                  if (value == null || value == "") {
                    return "Please enter note title.";
                  }

                  return null;
                },
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _descriptionController,
                focusNode: _descriptionNode,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 17.0,
                ),
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                selectionControls: MaterialTextSelectionControls(),
                minLines: 15,
                maxLines: 1000,
                //maxLength: 100000,
                validator: (value) {
                  if (value == null || value.trim() == "") {
                    return "Please enter note description.";
                  }

                  return null;
                },
                onSaved: (value) => _description = value?.trim() ?? "",
                decoration: AppConstants.inputDecoration.copyWith(
                  hintText: "Write Something...",
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Material(
                //elevation: 5,
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  width: 100,
                  height: 80,
                  color: Colors.amberAccent.withOpacity(0.3),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              'Attachments',
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              selectFile();
                            },
                            icon: const Icon(
                              Icons.attach_file_outlined,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              selectImage();
                            },
                            icon: const Icon(
                              Icons.image_outlined,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              selectCamera();
                            },
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.record_voice_over_outlined,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Material(
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  // height: 200,
                  color: Colors.amberAccent.withOpacity(0.3),
                  child: chosenFiles != null
                      ? GridViewAttachments(files: chosenFiles)
                      : Container(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              CustomButton(
                onTap: () {
                  _saveNote();
                  Navigator.of(context).pop();
                },
                title: "Save Note",
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveNote() {
    if (!(_form.currentState?.validate() ?? true)) return;

    _form.currentState?.save();
    DateTime date_to_record = _startDate;
    List<String> attachments = [];
    print(
        'here in the shit ---------------------------------------------------');
    print(_title);
    print('printed');

    if (chosenFiles.isNotEmpty) {
      attachments = chosenFiles;
    }
    Notes note;
    if (widget.note != null) {
      note = widget.note as Notes;
      note.title = _title;
      note.description = _description;
      note.timestamp = date_to_record;
      note.attachments = attachments;
    } else {
      note = Notes(
          title: _title,
          description: _description,
          timestamp: date_to_record,
          attachments: attachments);
    }

    context
        .read<NotesBloc>()
        .add(SaveNote(note: note, noteAction: widget.noteAction));
    // widget.onEventAdd?.call(event);
    _resetForm();
  }

  void _resetForm() {
    _form.currentState?.reset();
    _startDateController.text = "";
  }

  Future selectImage() async {
    try {
      List<String> converted_files = [];
      final List<XFile>? selectedImages = await ImagePicker().pickMultiImage();
      if (selectedImages!.isEmpty) {
        return;
      }

      for (int i = 0; i < selectedImages.length; i++) {
        converted_files.add(selectedImages[i].path);
      }

      setState(() {
        chosenFiles.addAll(converted_files);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future selectCamera() async {
    try {
      String converted_file;
      final XFile? selectedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (selectedImage == null) {
        return;
      }
      converted_file = selectedImage.path;

      setState(() {
        chosenFiles.add(converted_file);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future selectFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'ppt', 'pptx'],
      );
      if (result != null) {
        List<String> converted_files =
            result.paths.map((path) => path!).toList();
        setState(() {
          chosenFiles.addAll(converted_files);
        });
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}
