import 'package:core_tech/features/orders_home_screen/components/modal_quantidade.dart';
import 'package:core_tech/features/orders_home_screen/controllers/orders_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../../global/enum/enum.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<OrdersController>().recuperaListaProdutos();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OrdersController>();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        centerTitle: true,
        title: Text("Escolha um produto"),
      ),
      body: Builder(
        builder: (context) {
          switch (controller.listaProdutosState) {
            case LocalState.error:
              return Center(child: Text(controller.erro));
            case LocalState.loading:
              return Center(
                child: CircularProgressIndicator(),
              );
            case LocalState.idle:
              return Container();
            case LocalState.sucesso:
              return ListView.builder(
                itemCount: controller.listaProdutosParaEscolher.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(18),
                      tileColor: index % 2 == 0 ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.surfaceContainerHighest,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ModalQuantidade(
                            index: index,
                            produto: controller.listaProdutosParaEscolher[index],
                          ),
                        );
                      },
                      title: Text(
                        controller.listaProdutosParaEscolher[index]['nome'],
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        children: [
                          const Divider(),
                          Text(controller.listaProdutosParaEscolher[index]['descricao']),
                        ],
                      ),
                      trailing: Text(
                        "R\$ ${controller.listaProdutosParaEscolher[index]['valor']}",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
