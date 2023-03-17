import 'package:flutter/material.dart';
import 'package:storyapp/screens/home_screen.dart';
import 'package:storyapp/screens/login_screen.dart';
import 'package:storyapp/screens/register_screen.dart';
import 'package:storyapp/services/token_service.dart';
import 'package:storyapp/widgets/loading_spinner.dart';

void main() {
  runApp(const StoryApp());
}

class StoryApp extends StatelessWidget {
  const StoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: TokenService.getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final token = snapshot.data;
          return MaterialApp(
            title: 'My App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            initialRoute:
                token != null ? HomeScreen.routeName : LoginScreen.routeName,
            routes: {
              LoginScreen.routeName: (ctx) => const LoginScreen(),
              RegisterScreen.routeName: (ctx) => const RegisterScreen(),
              HomeScreen.routeName: (ctx) => const HomeScreen(),
            },
          );
        } else {
          return const LoadingSpinner();
        }
      },
    );
  }
}
