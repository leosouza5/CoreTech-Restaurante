// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:core_tech/global/enum/enum.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PedidosController extends ChangeNotifier {
  List pedidos = [];

  LocalState pedidosState = LocalState.idle;
  var erro;

  void recuperarPedidos() async {
    final dio = Dio();
    const url = 'http://192.168.0.202:3000/orders';

    try {
      pedidosState = LocalState.loading;
      notifyListeners();
      final response = await dio.get(url);
      print(response);

      if (response.data is Map && response.data.containsKey('error')) {
        throw response.data['error'];
      }

      pedidos = response.data;
      pedidosState = LocalState.sucesso;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      erro = e.toString();
      pedidosState = LocalState.error;
      notifyListeners();
    }
  }
}
