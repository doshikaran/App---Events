import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('64d2bd2ff3d5f719d729')
    .setSelfSigned(
        status: true); // For self signed certificates, only use for development

