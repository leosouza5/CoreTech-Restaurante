// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:core_tech/global/enum/enum.dart';
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
    const url = 'http://192.168.0.202:3000/cardapio';

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
    const url = 'http://192.168.0.202:3000/cardapios';

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
    final url = 'http://192.168.0.202:3000/cardapio/produtos/$id';

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
    const url = 'http://192.168.0.202:3000/cardapio/produto';

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
    final url = 'http://192.168.0.202:3000/cardapio/produto/$idProduto';
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
    final url = 'http://192.168.0.202:3000/cardapio/$idCardapio';
    print(url);

    print(body);

    try {
      final response = await dio.patch(url, data: body);
      print(response);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cardápio atualizado com sucesso !")),
      );
      recuperarProdutosCardapio(context, ultimoCardapioSelecionado, nomeCardapioSelecionado);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao atualizar Cardápio !")),
      );
    }
  }

  void removerProduto(BuildContext context, int id) async {
    final dio = Dio();
    final url = 'http://192.168.0.202:3000/cardapio/produto/$id';

    try {
      final response = await dio.delete(url);
      print(response);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Produto deletado com sucesso !")),
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
