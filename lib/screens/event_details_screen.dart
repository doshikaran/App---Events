import 'package:appwrite/models.dart';
import 'package:events/database/database.dart';
import 'package:events/screens/home_screen.dart';
import 'package:events/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? preferences;
String getUserId() {
  return preferences?.getString("userId") ?? "";
}

class EventDetails extends StatefulWidget {
  final Document data;
  static MaterialPageRoute route({required Document data}) =>
      MaterialPageRoute(builder: (context) => EventDetails(data: data));
  const EventDetails({super.key, required this.data});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  bool isregistered = false;
  String id = "";

  isuserregister(List<dynamic> eventParticipants, String userId) {
    return eventParticipants.contains(userId);
  }

  @override
  void initState() {
    super.initState();
    id = getUserId();
    isregistered = isuserregister(widget.data.data["eventParticipants"], id);
  }

  void _goback() {
    Navigator.pop(context);
  }

  void _shareEvent() {
    final eventDetails = '''${widget.data.data["eventName"]}
Description: ${widget.data.data["eventDescription"]}
at ${widget.data.data["eventLocation"]}
on ${widget.data.data["eventDateTime"]}

''';
    final eventDetailsUri = Uri.dataFromString(eventDetails);
    Share.shareUri(eventDetailsUri);
  }

  // register for the event function
  void register() {
    registerEvent(widget.data.data["eventParticipants"], widget.data.$id)
        .then((value) => {
              if (value)
                {
                  setState(() {
                    isregistered = true;
                  }),
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("You are registered.")))
                }
              else
                {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Couldnt register, try again.")))
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: _goback,
            icon: const Icon(
              Icons.arrow_back,
              color: Pallete.blackColor,
            )),
        actions: [
          IconButton(
            onPressed: _shareEvent,
            icon: const Icon(Icons.share_rounded, color: Pallete.blackColor),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
                'https://cloud.appwrite.io/v1/storage/buckets/64d4419b0fba55ae6443/files/${widget.data.data["eventImage"]}/view?project=64d2bd2ff3d5f719d729&'),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.data.data["eventName"]}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                Text(
                    "${widget.data.data["eventParticipants"].length} people are attending"),
                const SizedBox(height: 10),
                LocationAndDate(widget: widget),
                const SizedBox(height: 15),
                Description(widget: widget),
                GuestAndSponor(
                  widget: widget,
                ),
                const SizedBox(height: 15),
                isregistered
                    ? _attending()
                    : Center(
                        child: MaterialButton(
                        minWidth: double.infinity,
                        color: Pallete.purpleColor,
                        onPressed: () {
                          register();
                        },
                        child: const Text(
                          "Reigster Now",
                          style: TextStyle(
                              color: Pallete.whiteColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2),
                        ),
                      ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _attending extends StatelessWidget {
  const _attending({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: MaterialButton(
      minWidth: double.infinity,
      color: Pallete.purpleColor,
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("You are already registered.")));
      },
      child: const Text(
        "Attending",
        style: TextStyle(
            color: Pallete.whiteColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 2),
      ),
    ));
  }
}

class Description extends StatelessWidget {
  const Description({
    super.key,
    required this.widget,
  });

  final EventDetails widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Description",
          style: TextStyle(
              fontSize: 18,
              color: Pallete.blackColor,
              fontWeight: FontWeight.w500,
              letterSpacing: 2),
        ),
        const SizedBox(height: 10),
        Text(
          "${widget.data.data["eventDesc"]}",
          style: const TextStyle(
              fontSize: 14, letterSpacing: 1, fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class GuestAndSponor extends StatelessWidget {
  const GuestAndSponor({
    super.key,
    required this.widget,
  });

  final EventDetails widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            const Text(
              "Guests",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 3, 3, 3),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              "${widget.data.data["eventGuests"]}",
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 138, 137, 137),
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              "Event is Sponored by",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 3, 3, 3),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              "${widget.data.data["eventSponsors"]}",
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 138, 137, 137),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class LocationAndDate extends StatelessWidget {
  const LocationAndDate({
    super.key,
    required this.widget,
  });

  final EventDetails widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            const Icon(
              Icons.date_range_rounded,
              size: 14,
              color: Color.fromARGB(255, 138, 137, 137),
            ),
            const SizedBox(width: 4),
            Text(
              DateFormat('MMM dd, yyyy - h:mm a')
                  .format(DateTime.parse(widget.data.data["eventDateTime"])),
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 138, 137, 137),
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.location_city_rounded,
              size: 14,
              color: Color.fromARGB(255, 138, 137, 137),
            ),
            const SizedBox(width: 4),
            Text(
              "${widget.data.data["eventLocation"]}",
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 138, 137, 137),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
