import 'package:core_tech/features/web_home_screen/screens/web_home_screen.dart';
import 'package:core_tech/global/enum/enum.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  TextEditingController controllerUsuario = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LocalState authState = LocalState.idle;

  validaLogin(BuildContext context) async {
    final dio = Dio();
    const url = 'http://192.168.0.202:3000/auth';

    if (formKey.currentState!.validate()) {
      try {
        authState = LocalState.loading;
        notifyListeners();

        final response = await dio.post(url, data: {
          "nome": controllerUsuario.text,
          "senha": controllerSenha.text,
        });
        if (response.data is Map && response.data.containsKey('error')) {
          throw response.data['error'];
        }
        authState = LocalState.sucesso;
        notifyListeners();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => WebHomeScreen(),
            ));
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
