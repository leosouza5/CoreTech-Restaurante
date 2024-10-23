import 'package:core_tech/features/auth_screen/screens/auth_screen.dart';
import 'package:core_tech/features/food_menu/controller/food_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'global/theme/theme.dart';
import 'global/util/util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final brilho = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");
    MaterialTheme theme = MaterialTheme(textTheme);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FoodMenuController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CoreTech',
        theme: theme.light(),
        home: const AuthScreen(),
      ),
    );
  }
}
