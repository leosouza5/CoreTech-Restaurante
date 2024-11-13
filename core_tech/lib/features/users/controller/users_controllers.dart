// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:core_tech/global/enum/enum.dart';
import 'package:core_tech/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UsersControllers extends ChangeNotifier {
  List usuarios = [];

  LocalState listaUserState = LocalState.idle;
  var erro;

  void recuperarUsuarios() async {
    final dio = Dio();
    const url = '$urlServer/auth/users';

    try {
      listaUserState = LocalState.loading;
      notifyListeners();
      final response = await dio.get(url);
      print(response);

      if (response.data is Map && response.data.containsKey('error')) {
        throw response.data['error'];
      }

      usuarios = response.data;
      listaUserState = LocalState.sucesso;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      erro = e.toString();
      listaUserState = LocalState.error;
      notifyListeners();
    }
  }

  void criarUsuario(BuildContext context, Map data) async {
    final dio = Dio();
    const url = '$urlServer/auth/user';

    try {
      final response = await dio.post(url, data: data);
      print(response);

      if (response.data is Map && response.data.containsKey('error')) {
        throw response.data['error'];
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.data['sucesso'])),
      );
      Navigator.pop(context);
      recuperarUsuarios();
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void atualizaUsuario(BuildContext context, Map data, int id) async {
    final dio = Dio();
    final url = '$urlServer/auth/user/$id';

    try {
      final response = await dio.patch(url, data: data);
      print(response);

      if (response.data is Map && response.data.containsKey('error')) {
        throw response.data['error'];
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.data['sucesso'])),
      );
      Navigator.pop(context);
      recuperarUsuarios();
    } catch (e) {
      // print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void deletaUsuario(BuildContext context, int id) async {
    final dio = Dio();
    final url = '$urlServer/auth/user/$id';

    try {
      final response = await dio.delete(
        url,
      );
      print(response);

      if (response.data is Map && response.data.containsKey('error')) {
        throw response.data['error'];
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.data['sucesso'])),
      );
      Navigator.pop(context);
      recuperarUsuarios();
    } catch (e) {
      // print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}
