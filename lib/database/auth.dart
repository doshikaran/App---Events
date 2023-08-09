import 'package:appwrite/appwrite.dart';
import 'package:events/constants/appwrite_constants.dart';
import 'package:events/database/database.dart';

Client client = Client()
    .setEndpoint(AppwriteConstants.endPoint)
    .setProject(AppwriteConstants.projectId)
    .setSelfSigned(
        status: true); // For self signed certificates, only use for development

// Register User
Account account = Account(client);
Future<String> createUser(String name, String email, String password) async {
  try {
    final user = await account.create(
        userId: ID.unique(), email: email, password: password, name: name);
    saveUserData(name, email, user.$id);
    return "User created successfully";
  } on AppwriteException catch (error) {
    return error.message.toString();
  }
}

// Login user
Future<String> loginUser(String email, String password) async {
  try {
    final user = await account.createEmailSession(
      email: email,
      password: password,
    );
    return "User logged successfully";
  } on AppwriteException catch (error) {
    return error.message.toString();
  }
}

// Logout user
Future logoutUser() async {
  await account.deleteSession(sessionId: 'current');
}

// check user session
Future checkUserSession() async {
  try {
    final user = await account.getSession(sessionId: 'current');
    return "user";
  } catch (error) {
    return error;
  }
}
