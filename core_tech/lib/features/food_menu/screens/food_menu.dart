import 'package:core_tech/features/food_menu/components/modal_novo_cardapio.dart';
import 'package:core_tech/features/food_menu/components/modal_novo_produto.dart';
import 'package:core_tech/features/food_menu/components/produto_linha.dart';
import 'package:core_tech/features/food_menu/controller/food_menu_controller.dart';
import 'package:core_tech/global/enum/enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../web_home_screen/components/botao_acao_rapida.dart';

class FoodMenu extends StatefulWidget {
  const FoodMenu({super.key});

  @override
  State<FoodMenu> createState() => _FoodMenuState();
}

class _FoodMenuState extends State<FoodMenu> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<FoodMenuController>().recuperarCardapios(context);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<FoodMenuController>();

    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          toolbarHeight: 90,
          leadingWidth: 150,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: AssetImage('assets/images/logo.webp'), fit: BoxFit.fitWidth),
              ),
            ),
          ),
          centerTitle: true,
          title: Text("Cardápios"),
          actions: [
            BotaoAcaoRapida(
              icon: Icon(Icons.exit_to_app, size: 30),
              label: "Voltar",
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: Row(
          children: [
            Expanded(
              flex: 2,
              child: Builder(
                builder: (context) {
                  switch (controller.cardapiosState) {
                    case LocalState.loading:
                      return Center(child: CircularProgressIndicator());
                    case LocalState.error:
                      return Text("Erro ao recuperar Cardapios");
                    case LocalState.idle:
                      return Container();
                    case LocalState.sucesso:
                      return Column(
                        children: [
                          SizedBox(height: 100),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => ModalNovoCardapio(),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                backgroundColor: Theme.of(context).colorScheme.tertiary,
                              ),
                              child: Text(
                                "Novo Cardápio",
                                style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: controller.listaCardapios.length,
                              itemBuilder: (context, index) {
                                return RawMaterialButton(
                                  shape: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Theme.of(context).colorScheme.surfaceContainerHighest),
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  onPressed: () {
                                    controller.recuperarProdutosCardapio(context, controller.listaCardapios[index]['id'], controller.listaCardapios[index]['nome']);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(),
                                      Text(controller.listaCardapios[index]['nome']),
                                      controller.listaCardapios[index]['ativo'] ? Icon(Icons.star_outline) : Container(),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      );
                  }
                },
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                ),
                child: Builder(builder: (context) {
                  switch (controller.cardapioEspecificoState) {
                    case LocalState.loading:
                      return Center(child: CircularProgressIndicator());
                    case LocalState.error:
                      return Text("Erro ao recupera Cardapio");
                    case LocalState.idle:
                      return Center(
                        child: Text("Selecione um Cardápio para visualizar."),
                      );
                    case LocalState.sucesso:
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                Text(
                                  controller.nomeCardapioSelecionado,
                                  style: TextStyle(fontSize: 24),
                                ),
                                RawMaterialButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.all(12),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => ModalNovoCardapio(
                                        edicao: true,
                                        nomeCardapio: controller.nomeCardapioSelecionado,
                                        idCardapio: controller.ultimoCardapioSelecionado,
                                      ),
                                    );
                                  },
                                  child: const Icon(Icons.edit),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Expanded(
                            child: ListView.builder(
                              itemCount: controller.produtos.length,
                              itemBuilder: (context, index) => ProdutoLinha(
                                id: controller.produtos[index]['id'],
                                descricao: controller.produtos[index]['descricao'],
                                nome: controller.produtos[index]['nome'],
                                valor: controller.produtos[index]['valor'],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0), // Adiciona espaçamento ao redor do botão
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => ModalNovoProduto(
                                    idCardapio: controller.ultimoCardapioSelecionado,
                                  ),
                                );
                                // controller.adiconarProdutoExtra();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Theme.of(context).colorScheme.tertiary,
                              ),
                              child: Icon(
                                Icons.add,
                                color: Theme.of(context).colorScheme.onTertiary,
                              ),
                            ),
                          ),
                        ],
                      );
                  }
                }),
              ),
            ),
          ],
        ));
  }
}
