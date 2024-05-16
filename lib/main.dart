import 'package:dating_app/features/chat/data/services/chat_user.dart';
import 'package:dating_app/features/splash/presention/splash_view.dart';
import 'package:dating_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main()async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const DatingApp());
}
class DatingApp extends StatelessWidget {
  const DatingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatService(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:SplashViewBody(),
      ),
    );
  }
}

