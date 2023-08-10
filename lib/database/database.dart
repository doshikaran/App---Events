import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:events/constants/appwrite_constants.dart';
import 'package:events/database/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Databases databases = Databases(client);

SharedPreferences? preferences;
String getUserId() {
  return preferences?.getString("userId") ?? "";
}

// save user data
Future<void> saveUserData(String name, String email, String userId) async {
  try {
    await databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.userdataCollectionId,
        documentId: ID.unique(),
        data: {
          'name': name,
          'email': email,
          'userId': userId
        }).then((value) => print("Document created successfully"));
  } catch (error) {
    print(error);
  }
}

// create event
Future<void> createEvent(
    String eventName,
    String eventDesc,
    String eventImage,
    String eventLocation,
    String eventDateTime,
    String eventGuests,
    String eventSponsors,
    String createdBy) async {
  try {
    await databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.eventsCollectionId,
        documentId: ID.unique(),
        data: {
          'eventName': eventName,
          'eventDesc': eventDesc,
          'eventImage': eventImage,
          'eventLocation': eventLocation,
          'eventDateTime': eventDateTime,
          'eventGuests': eventGuests,
          'eventSponsors': eventSponsors,
          'createdBy': createdBy,
        }).then((value) => print("Event created successfully"));
  } catch (error) {
    print(error);
  }
}

// get events
Future getEvents() async {
  try {
    final data = await databases.listDocuments(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.eventsCollectionId,
    );
    return data.documents;
  } catch (error) {
    print(error);
  }
}

// register for the event
Future registerEvent(List eventParticipants, String documentId) async {
  final userId = getUserId();
  eventParticipants.add(userId);
  try {
    await databases.updateDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.eventsCollectionId,
        documentId: documentId,
        data: {
          'eventParticipants': eventParticipants,
        });
    return true;
  } catch (error) {
    print(error);
    return false;
  }
}
