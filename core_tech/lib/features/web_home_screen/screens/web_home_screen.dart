import 'package:core_tech/features/food_menu/screens/food_menu.dart';
import 'package:core_tech/features/users/screens/users.dart';
import 'package:core_tech/features/web_home_screen/components/header_tabela.dart';
import 'package:core_tech/features/web_home_screen/controller/pedidos_controller.dart';
import 'package:core_tech/features/web_home_screen/screens/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/enum/enum.dart';
import '../components/botao_acao_rapida.dart';

class WebHomeScreen extends StatefulWidget {
  const WebHomeScreen({super.key});

  @override
  State<WebHomeScreen> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<PedidosController>().recuperarPedidos();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PedidosController>();
    return Scaffold(
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
              image: const DecorationImage(image: AssetImage('assets/images/logo.webp'), fit: BoxFit.fitWidth),
            ),
          ),
        ),
        actions: [
          BotaoAcaoRapida(
            icon: const Icon(Icons.person, size: 30),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Users(),
                )),
            label: "Usuários",
          ),
          const BotaoAcaoRapida(
            icon: Icon(Icons.savings_outlined, size: 30),
            label: "Relatorio",
          ),
          BotaoAcaoRapida(
            label: "Cardapio",
            icon: const Icon(Icons.local_pizza, size: 30),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FoodMenu(),
                )),
          ),
          const BotaoAcaoRapida(
            label: "Sair",
            icon: Icon(Icons.logout, size: 30),
          ),
        ],
        title: const Text("CoreTech"),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.sizeOf(context).width * .8,
          height: MediaQuery.sizeOf(context).height * .8,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Builder(
              builder: (context) {
                switch (controller.pedidosState) {
                  case LocalState.error:
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            controller.erro,
                            style: TextStyle(fontSize: 25),
                          ),
                          SizedBox(height: 100),
                          RawMaterialButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(12),
                            onPressed: () {
                              controller.recuperarPedidos();
                            },
                            child: Icon(Icons.refresh),
                          ),
                        ],
                      ),
                    );
                  case LocalState.loading:
                    return Center(child: CircularProgressIndicator());
                  case LocalState.idle:
                    return Container();
                  case LocalState.sucesso:
                    return Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text(
                              "Pedidos",
                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Divider(),
                        Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                        Expanded(
                          child: Table(
                            children: [
                              TableRow(
                                children: [
                                  HeaderTabela(
                                      icon: Icon(Icons.shopping_cart),
                                      titulo: Text(
                                        'Pedido',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                      )),
                                  HeaderTabela(
                                      icon: Icon(Icons.desk),
                                      titulo: Text(
                                        'Mesa',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                      )),
                                  HeaderTabela(
                                      icon: Icon(Icons.date_range),
                                      titulo: Text(
                                        'Data',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                      )),
                                  HeaderTabela(
                                      icon: Icon(Icons.attach_money),
                                      titulo: Text(
                                        'Valor',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                      )),
                                  HeaderTabela(
                                      icon: Icon(Icons.attach_money),
                                      titulo: Text(
                                        'Ação',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                      )),
                                ],
                              ),
                              ...controller.pedidos.map(
                                (e) => TableRow(
                                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainer),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(32),
                                      child: TableCell(
                                        child: SizedBox(
                                          child: Center(child: Text(e['id'].toString())),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(32),
                                      child: TableCell(
                                        child: SizedBox(
                                          child: Center(child: Text(e['mesa'])),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(32),
                                      child: TableCell(
                                        child: SizedBox(
                                          child: Center(
                                            child: Text("${e['data_pedido'].substring(8, 10)}/${e['data_pedido'].substring(5, 7)}/${e['data_pedido'].substring(0, 4)}"),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(32),
                                      child: TableCell(
                                        child: SizedBox(
                                          child: Center(child: Text(e['valor_total'])),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(22),
                                      child: TableCell(
                                        child: SizedBox(
                                          child: Center(
                                            child: IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => OrderScreen(idPedido: e['id']),
                                                      ));
                                                },
                                                icon: Icon(Icons.visibility)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
