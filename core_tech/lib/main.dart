import 'package:core_tech/features/auth_screen/controller/auth_controller.dart';
import 'package:core_tech/features/auth_screen/screens/auth_screen.dart';
import 'package:core_tech/features/food_menu/controller/food_menu_controller.dart';
import 'package:core_tech/features/food_menu/screens/food_menu.dart';
import 'package:core_tech/features/orders_home_screen/controllers/orders_controller.dart';
import 'package:core_tech/features/orders_resume/screens/orders_resume.dart';
import 'package:core_tech/features/users/controller/users_controllers.dart';
import 'package:core_tech/features/web_home_screen/controller/pedidos_controller.dart';
import 'package:core_tech/features/web_home_screen/screens/order_screen.dart';
import 'package:core_tech/features/web_home_screen/screens/web_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'global/theme/theme.dart';
import 'global/util/util.dart';

const urlServer = 'http://192.168.0.202:3030';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
  Intl.defaultLocale = 'pt_BR';

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
        ChangeNotifierProvider(create: (context) => AuthController()),
        ChangeNotifierProvider(create: (context) => UsersControllers()),
        ChangeNotifierProvider(create: (context) => PedidosController()),
        ChangeNotifierProvider(create: (context) => OrdersController()),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
        ],
        locale: const Locale('pt', 'BR'),
        debugShowCheckedModeBanner: false,
        title: 'CoreTech',
        theme: theme.light(),
        home: OrdersResume(),
      ),
    );
  }
}
