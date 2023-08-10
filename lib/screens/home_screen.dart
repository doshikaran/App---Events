import 'package:appwrite/models.dart';
import 'package:events/database/database.dart';
import 'package:events/screens/create_event_screen.dart';
import 'package:events/screens/event_details_screen.dart';
import 'package:events/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../database/auth.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomeScreen());
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Document> events = [];
  String username = "";

  @override
  void initState() {
    super.initState();

    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    final eventList = await getEvents();
    setState(() {
      events = eventList;
    });
  }

  void onlogout() {
    logoutUser();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Logged out Successfully")),
    );
    Navigator.pushReplacement(context, LoginScreen.route());
  }

  void oncreateevent() async {
    await Navigator.push(context, CreateEventScreen.route());
    _fetchEvents();
  }

  void oneventdetail(Document event) {
    Navigator.push(context, EventDetails.route(data: event));
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final upcomingEvents = events.where((event) {
      final eventDateTime = DateTime.parse(event.data["eventDateTime"]);
      return eventDateTime.isAfter(now);
    }).toList();

    final pastEvents = events.where((event) {
      final eventDateTime = DateTime.parse(event.data["eventDateTime"]);
      return eventDateTime.isBefore(now);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to Events App",
            style: TextStyle(
                fontSize: 24,
                color: Pallete.blackColor,
                fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: onlogout,
              icon: const Icon(
                Icons.logout_rounded,
                color: Pallete.blackColor,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            const Text("Upcoming Events",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            if (upcomingEvents.isNotEmpty)
              for (final event in upcomingEvents)
                EventCard(event: event, onPressed: oneventdetail),
            if (upcomingEvents.isEmpty)
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Pallete.eventCardColor,
                ),
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: const Text(
                  "No upcoming events",
                  style: TextStyle(
                    fontSize: 16,
                    color: Pallete.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 10),
            const Text("Past Events",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            for (final event in pastEvents)
              EventCard(event: event, onPressed: oneventdetail),
            FloatingActionButton.small(
                onPressed: oncreateevent, child: const Icon(Icons.add)),
          ]),
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Document event;
  final Function onPressed;

  const EventCard({required this.event, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(event),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Pallete.eventCardColor,
          ),
          margin: const EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('MMM dd, yyyy - h:mm a').format(
                                DateTime.parse(event.data["eventDateTime"])),
                            style: const TextStyle(
                                fontSize: 14, color: Pallete.whiteColor),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            event.data['eventName'],
                            style: const TextStyle(
                                color: Pallete.eventCardTitlColor,
                                fontSize: 20,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                              "https://cloud.appwrite.io/v1/storage/buckets/64d4419b0fba55ae6443/files/${event.data["eventImage"]}/view?project=64d2bd2ff3d5f719d729&"),
                        ),
                      )
                    ]),
                const SizedBox(height: 10),
                Text(
                  event.data['eventDesc'],
                  maxLines: 2,
                  style: const TextStyle(
                      color: Pallete.whiteColor,
                      fontSize: 13,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
