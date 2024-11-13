// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:core_tech/global/enum/enum.dart';
import 'package:core_tech/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PedidosController extends ChangeNotifier {
  List pedidos = [];
  Map pedido = {};

  LocalState pedidosState = LocalState.idle;
  LocalState fechaPedidoState = LocalState.idle;
  var erro;

  void recuperarPedidos() async {
    final dio = Dio();
    const url = '$urlServer/orders';

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

  void recuperarPedidoEspecifico(int idPedido) async {
    final dio = Dio();
    final url = '$urlServer/orders/pedidoCompleto/$idPedido';

    try {
      fechaPedidoState = LocalState.loading;
      notifyListeners();
      final response = await dio.get(url);
      print(response);

      if (response.data is Map && response.data.containsKey('error')) {
        throw response.data['error'];
      }

      pedido = response.data[0];
      fechaPedidoState = LocalState.sucesso;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      erro = e.toString();
      fechaPedidoState = LocalState.error;
      notifyListeners();
    }
  }

  void finalizaPedido(int idPedido, String metodoDePagamento, BuildContext context) async {
    final dio = Dio();
    final url = '$urlServer/order/$idPedido';
    print(url);

    try {
      final response = await dio.patch(url, data: {'metodo_pagamento': metodoDePagamento});
      print(response);

      if (response.data is Map && response.data.containsKey('error')) {
        throw response.data['error'];
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.data['sucesso'])),
      );
      recuperarPedidos();
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}
