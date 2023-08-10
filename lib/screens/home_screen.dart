import 'package:appwrite/models.dart';
import 'package:events/database/database.dart';
import 'package:events/screens/create_event_screen.dart';
import 'package:events/screens/event_details_screen.dart';
import 'package:events/theme/pallete.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
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
            const Text("Welcome to Events App",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Pallete.greyColor,
                  ),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    onTap: () => oneventdetail(event),
                    leading: Image.network(
                        "https://cloud.appwrite.io/v1/storage/buckets/64d4419b0fba55ae6443/files/${event.data["eventImage"]}/view?project=64d2bd2ff3d5f719d729&"),
                    title: Text(
                      events[index].data['eventName'],
                    ),
                    subtitle: Text(
                      events[index].data['eventDesc'],
                      maxLines: 3,
                    ),
                  ),
                );
              },
            ),
            FloatingActionButton.small(
                onPressed: oncreateevent, child: const Icon(Icons.add)),
          ]),
        ),
      ),
    );
  }
}
