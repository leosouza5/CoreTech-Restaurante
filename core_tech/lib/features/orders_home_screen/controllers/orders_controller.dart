import 'package:core_tech/global/enum/enum.dart';
import 'package:core_tech/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OrdersController extends ChangeNotifier {
  LocalState listaProdutosState = LocalState.idle;
  LocalState enviaProdutosState = LocalState.idle;
  LocalState pedidosState = LocalState.idle;

  var erro;

  List listaProdutosParaEscolher = [];
  List listaProdutosDoPedido = [];
  List pedidos = [];
  String mesa = '01';
  double get valorTotal {
    double v = 0;
    listaProdutosDoPedido.forEach(
      (element) => v += double.parse(element['valor']) * (element['quantidade'] is String ? double.parse(element['quantidade']) : element['quantidade']),
    );
    return v;
  }

  void enviaPedido(BuildContext context, {bool edicao = false, int? idPedido}) async {
    final dio = Dio();
    final url = edicao ? '$urlServer/order/$idPedido' : '$urlServer/order';

    print(url);
    List idProdutos = [];

    try {
      enviaProdutosState = LocalState.loading;
      notifyListeners();
      for (var produto in listaProdutosDoPedido) {
        idProdutos.add({'id': produto['id'], 'quantidade': produto['quantidade']});
      }

      final pedido = {
        "valor_total": valorTotal,
        "mesa": mesa,
        "produtos": idProdutos,
      };
      late final response;
      print(pedido);
      if (edicao) {
        response = await dio.put(url, data: pedido);
      } else {
        response = await dio.post(url, data: pedido);
      }
      print(response);

      if (response.data is Map && response.data.containsKey('error')) {
        throw response.data['error'];
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.data['sucesso'])),
      );
      recuperaPedidos();
      enviaProdutosState = LocalState.sucesso;
      notifyListeners();
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
      print(e.toString());
      enviaProdutosState = LocalState.error;
      notifyListeners();
    }
  }

  void recuperaListaProdutos() async {
    final dio = Dio();
    const url = '$urlServer/principal/cardapio';

    print(url);

    try {
      listaProdutosState = LocalState.loading;
      notifyListeners();
      final response = await dio.get(url);
      print(response);

      if (response.data is Map && response.data.containsKey('error')) {
        throw response.data['error'];
      }

      listaProdutosParaEscolher = response.data;
      listaProdutosState = LocalState.sucesso;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      erro = e.toString();
      listaProdutosState = LocalState.error;
      notifyListeners();
    }
  }

  void recuperaPedidos() async {
    final dio = Dio();
    const url = '$urlServer/orders';

    print(url);

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

  void recuperaProdutosDoPedido(int idPedido) async {
    final dio = Dio();
    final url = '$urlServer/order/pedido/$idPedido';

    print(url);

    try {
      final response = await dio.get(url);
      print(response);

      if (response.data is Map && response.data.containsKey('error')) {
        throw response.data['error'];
      }

      listaProdutosDoPedido = response.data;
      print(listaProdutosDoPedido.first['mesa']);
      mesa = listaProdutosDoPedido.first['mesa'].toString();

      notifyListeners();
    } catch (e) {
      print(e.toString());
      erro = e.toString();
    }
  }

  void removeProdutoDoPedido(int index) {
    listaProdutosDoPedido.removeAt(index);
    notifyListeners();
  }

  void reset() {
    listaProdutosDoPedido.clear();
    listaProdutosParaEscolher.clear();
    mesa = '01';
  }
}
