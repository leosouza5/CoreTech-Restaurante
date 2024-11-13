// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:core_tech/global/enum/enum.dart';
import 'package:core_tech/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FoodMenuController extends ChangeNotifier {
  List produtos = [];

  List listaCardapios = [];

  int ultimoCardapioSelecionado = 0;
  String nomeCardapioSelecionado = "";

  LocalState cardapiosState = LocalState.idle;
  LocalState cardapioEspecificoState = LocalState.idle;

  void novoCardapio(String nome, BuildContext context) async {
    final dio = Dio();
    const url = '$urlServer/cardapio';

    try {
      final response = await dio.post(url, data: {'nome': nome});
      print(response);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cardápio cadastrado com sucesso")),
      );
      recuperarCardapios(context);
      Navigator.pop(context);
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao salvar cardapio")),
      );
    }
  }

  recuperarCardapios(BuildContext context) async {
    final dio = Dio();
    const url = '$urlServer/cardapios';

    try {
      cardapiosState = LocalState.loading;
      notifyListeners();

      final response = await dio.get(url);
      print("response");
      print(response);
      listaCardapios = response.data;
      print(listaCardapios);
      cardapiosState = LocalState.sucesso;
      notifyListeners();
    } catch (e) {
      cardapiosState = LocalState.error;
      notifyListeners();
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao recuperar cardapios")),
      );
    }
  }

  void recuperarProdutosCardapio(BuildContext context, int id, String nomeCardapio) async {
    final dio = Dio();
    final url = '$urlServer/cardapio/produtos/$id';

    try {
      ultimoCardapioSelecionado = id;
      nomeCardapioSelecionado = nomeCardapio;
      cardapioEspecificoState = LocalState.loading;
      notifyListeners();

      final response = await dio.get(url);
      print(response);
      produtos = response.data;
      cardapioEspecificoState = LocalState.sucesso;
      notifyListeners();
    } catch (e) {
      cardapioEspecificoState = LocalState.error;
      notifyListeners();
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao recuperar produtos")),
      );
    }
  }

  void adicionarProdutoAoCardapio(BuildContext context, Map body) async {
    final dio = Dio();
    const url = '$urlServer/cardapio/produto';

    print(body);

    try {
      final response = await dio.post(url, data: body);
      print(response);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Produto cadastrado com sucesso !")),
      );
      recuperarProdutosCardapio(context, ultimoCardapioSelecionado, nomeCardapioSelecionado);
      Navigator.pop(context);
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao cadastrar produto !")),
      );
    }
  }

  void editaProduto(BuildContext context, Map body, int idProduto) async {
    final dio = Dio();
    final url = '$urlServer/cardapio/produto/$idProduto';
    print(url);

    print(body);

    try {
      final response = await dio.patch(url, data: body);
      print(response);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Produto atualizado com sucesso !")),
      );
      await recuperarCardapios(context);
      recuperarProdutosCardapio(context, ultimoCardapioSelecionado, nomeCardapioSelecionado);
      Navigator.pop(context);
    } catch (e) {
      print(e.toString());
      print(e.runtimeType);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao atualizar produto !")),
      );
    }
  }

  void editaCardapio(BuildContext context, Map body, int idCardapio) async {
    final dio = Dio();
    final url = '$urlServer/cardapio/$idCardapio';
    print(url);

    print(body);

    try {
      final response = await dio.patch(url, data: body);
      print(response);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cardápio atualizado com sucesso !")),
      );
      recuperarCardapios(context);
      cardapioEspecificoState = LocalState.idle;
      notifyListeners();
      // recuperarProdutosCardapio(context, ultimoCardapioSelecionado, nomeCardapioSelecionado);
      Navigator.pop(context);
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao atualizar Cardápio !")),
      );
    }
  }

  void tornaCardapioPrincipal(BuildContext context, int idCardapio) async {
    final dio = Dio();
    final url = '$urlServer/cardapio/$idCardapio';
    print(url);

    try {
      final response = await dio.put(url);
      print(response);
      if (response.data is Map && response.data.containsKey('error')) {
        throw response.data['error'];
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.data['sucesso'])),
      );
      recuperarCardapios(context);
      cardapioEspecificoState = LocalState.idle;
      notifyListeners();
      // recuperarProdutosCardapio(context, ultimoCardapioSelecionado, nomeCardapioSelecionado);
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void removerCardapio(BuildContext context, int id) async {
    final dio = Dio();
    final url = '$urlServer/cardapio/$id';

    try {
      final response = await dio.delete(url);
      print(response);
      if (response.data is Map && response.data.containsKey('error')) {
        throw response.data['error'];
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.data['sucesso'])),
      );
      recuperarCardapios(context);
      cardapioEspecificoState = LocalState.idle;
      notifyListeners();
      Navigator.pop(context);
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void removerProduto(BuildContext context, int id) async {
    final dio = Dio();
    final url = '$urlServer/cardapio/produto/$id';

    try {
      final response = await dio.delete(url);
      print(response);
      if (response.data is Map && response.data.containsKey('error')) {
        throw response.data['error'];
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.data['sucesso'])),
      );
      recuperarProdutosCardapio(context, ultimoCardapioSelecionado, nomeCardapioSelecionado);
      Navigator.pop(context);
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao remover produto !")),
      );
    }
  }
}
