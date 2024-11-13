import 'package:core_tech/features/web_home_screen/screens/web_home_screen.dart';
import 'package:core_tech/global/enum/enum.dart';
import 'package:core_tech/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../orders_home_screen/screens/orders_home_screen.dart';

class AuthController extends ChangeNotifier {
  TextEditingController controllerUsuario = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LocalState authState = LocalState.idle;

  validaLogin(BuildContext context) async {
    final dio = Dio();
    const url = '$urlServer/auth';

    if (formKey.currentState!.validate()) {
      try {
        authState = LocalState.loading;
        notifyListeners();

        final response = await dio.post(url, data: {
          "nome": controllerUsuario.text,
          "senha": controllerSenha.text,
        });
        print(response.data);
        if (response.data is Map && response.data.containsKey('error')) {
          throw response.data['error'];
        }
        authState = LocalState.sucesso;
        notifyListeners();

        if ((response.data[0]['tipo_usuario'] == 'G' || response.data[0]['tipo_usuario'] == 'A') && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.windows)) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => OrdersHomeScreen(),
              ));
        } else if ((response.data[0]['tipo_usuario'][0] == 'C' || response.data[0]['tipo_usuario'] == 'A') && (defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.linux)) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => WebHomeScreen(),
              ));
        } else {
          throw "Você não tem acesso a esta plataforma";
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login feito com sucesso !")),
        );
      } catch (e) {
        authState = LocalState.error;
        notifyListeners();
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }
}
