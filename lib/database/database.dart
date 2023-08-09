import 'package:appwrite/appwrite.dart';
import 'package:events/constants/appwrite_constants.dart';
import 'package:events/database/auth.dart';

final Databases databases = Databases(client);

// save user data
Future<void> saveUserData(String name, String email, String uid) async {
  try {
    await databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.userdataCollectionId,
        documentId: ID.unique(),
        data: {
          'name': name,
          'email': email,
          'uid': uid
        }).then((value) => print("Document created successfully"));
  } catch (error) {
    print(error);
  }
}
