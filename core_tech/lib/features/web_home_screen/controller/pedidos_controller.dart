// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:core_tech/global/enum/enum.dart';
import 'package:core_tech/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PedidosController extends ChangeNotifier {
  List pedidos = [];
  List pedidosFechados = [];
  Map pedido = {};

  LocalState pedidosState = LocalState.idle;
  LocalState fechaPedidoState = LocalState.idle;
  LocalState pedidosFechadosState = LocalState.idle;
  var erro;

  double get valorTotal {
    double v = 0;
    pedidosFechados.forEach(
      (element) => v += double.parse(element['valor_total']),
    );
    return v;
  }

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

  void recuperarPedidosFechados(String data) async {
    final dio = Dio();
    const url = '$urlServer/orders/fechado';
    Map<String, dynamic> body = {'data': data};
    print(body);
    try {
      pedidosFechadosState = LocalState.loading;
      notifyListeners();
      pedidosFechados.clear();
      final response = await dio.get(url, queryParameters: body);
      print(response);

      if (response.data is Map && response.data.containsKey('error')) {
        throw response.data['error'];
      }

      pedidosFechados = response.data;
      pedidosFechadosState = LocalState.sucesso;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      erro = e.toString();
      pedidosFechadosState = LocalState.error;
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
