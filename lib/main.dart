import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:live_score/app.dart';
import 'package:live_score/firebase_notification_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseNotificationService.instance.initialize();
  runApp(const LiveScore());
}