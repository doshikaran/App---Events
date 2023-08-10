// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:math';

import 'package:appwrite/appwrite.dart';
import 'package:events/constants/appwrite_constants.dart';
import 'package:events/database/database.dart';
import 'package:events/theme/theme.dart';
import 'package:events/widgets/custom_input.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/auth.dart';

class CreateEventScreen extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const CreateEventScreen());
  const CreateEventScreen({super.key});
  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _eventnameController = TextEditingController();
  final _eventDescController = TextEditingController();
  final _eventLocationController = TextEditingController();
  final _eventDateTimeController = TextEditingController();
  final _eventGuestsController = TextEditingController();
  final _eventSponsorsController = TextEditingController();

  FilePickerResult? _filePickerResult;

  Storage storage = Storage(client);
  bool _isUploading = false;

  // image picker
  void _openfilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    setState(() {
      _filePickerResult = result;
    });
  }

  // upload image to db storage
  Future uploadImage() async {
    setState(() {
      _isUploading = true;
    });
    if (_eventnameController.text == "" ||
        _eventDescController.text == "" ||
        _eventLocationController.text == "" ||
        _eventDateTimeController.text == "") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please fill all the fields.")));
    } else {
      try {
        if (_filePickerResult != null) {
          PlatformFile file = _filePickerResult!.files.first;
          final fileBytes = await File(file.path!).readAsBytes();
          final inputFile =
              InputFile.fromBytes(bytes: fileBytes, filename: file.name);
          final res = await storage.createFile(
              bucketId: AppwriteConstants.buckedId,
              fileId: ID.unique(),
              file: inputFile);
          print(res.$id);

          return res.$id;
        }
      } catch (e) {
        print(e);
      } finally {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  // date time picker
  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2099));

    if (pickDate != null) {
      final TimeOfDay? pickTime =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (pickTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickDate.year,
          pickDate.month,
          pickDate.day,
          pickTime.hour,
          pickTime.minute,
        );
        setState(() {
          _eventDateTimeController.text = selectedDateTime.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Create Event',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              _openfilePicker();
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(66, 159, 159, 159)),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.2,
              child: _filePickerResult == null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.image),
                        SizedBox(width: 10),
                        Text('Add an Image')
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: FileImage(
                          File(_filePickerResult!.files.first.path!),
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          CustomInput(
            hintext: 'Event Name',
            icon: Icons.event_outlined,
            label: "Event Name",
            controller: _eventnameController,
          ),
          SizedBox(
            height: 15,
          ),
          CustomInput(
              controller: _eventDescController,
              hintext: 'Description',
              icon: Icons.description_rounded,
              label: "Description"),
          SizedBox(
            height: 15,
          ),
          CustomInput(
              controller: _eventLocationController,
              hintext: 'Location',
              icon: Icons.location_on_rounded,
              label: "Location"),
          SizedBox(
            height: 15,
          ),
          CustomInput(
              onTap: () {
                _selectDateTime(
                  context,
                );
              },
              controller: _eventDateTimeController,
              hintext: 'Pick Date & Time',
              icon: Icons.date_range_outlined,
              label: "Date & Time"),
          SizedBox(
            height: 15,
          ),
          CustomInput(
              controller: _eventGuestsController,
              hintext: 'Guests',
              icon: Icons.people_alt_rounded,
              label: "Enter your Guests"),
          SizedBox(
            height: 15,
          ),
          CustomInput(
              controller: _eventSponsorsController,
              hintext: 'Sponors',
              icon: Icons.monetization_on,
              label: "Enter your Sponors"),
          SizedBox(
            height: 15,
          ),
          Center(
            child: MaterialButton(
              minWidth: double.infinity,
              color: Pallete.purpleColor,
              onPressed: () {
                uploadImage()
                    .then((value) => createEvent(
                        _eventnameController.text,
                        _eventDescController.text,
                        value,
                        _eventLocationController.text,
                        _eventDateTimeController.text,
                        _eventGuestsController.text,
                        _eventSponsorsController.text,
                        ""))
                    .then((value) => {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Event is Created"))),
                          Navigator.pop(context)
                        });
              },
              child: Text(
                "Create New Event",
                style: TextStyle(
                    color: Pallete.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
            ),
          )
        ]),
      )),
    );
  }
}
