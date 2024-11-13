import 'package:core_tech/features/users/controller/users_controllers.dart';
import 'package:core_tech/features/web_home_screen/components/modal_finaliza_pedido.dart';
import 'package:core_tech/features/web_home_screen/components/produto_linha_order.dart';
import 'package:core_tech/global/enum/enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../web_home_screen/components/botao_acao_rapida.dart';
import '../controller/pedidos_controller.dart';

class OrderScreen extends StatefulWidget {
  final int idPedido;
  const OrderScreen({super.key, required this.idPedido});

  @override
  State<OrderScreen> createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<PedidosController>().recuperarPedidoEspecifico(widget.idPedido);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PedidosController>();
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
          title: Text("Pedido ${controller.pedido['id']}"),
          actions: [
            BotaoAcaoRapida(
              icon: Icon(Icons.exit_to_app, size: 30),
              label: "Voltar",
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: Center(
          child: Container(
              width: MediaQuery.sizeOf(context).width * .8,
              height: MediaQuery.sizeOf(context).height * .8,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Builder(
                builder: (context) {
                  switch (controller.fechaPedidoState) {
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
                                controller.recuperarPedidoEspecifico(widget.idPedido);
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
                          Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Mesa ${controller.pedido['mesa']}",
                                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${controller.pedido['data_pedido'].substring(8, 10)}/${controller.pedido['data_pedido'].substring(5, 7)}/${controller.pedido['data_pedido'].substring(0, 4)}",
                                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Divider(height: 50),
                          Expanded(
                            child: ListView.builder(
                              itemCount: controller.pedido['produtos'].length,
                              itemBuilder: (context, index) => ProdutoLinhaOrder(
                                nome: controller.pedido['produtos'][index]['nome'],
                                quantidade: controller.pedido['produtos'][index]['quantidade'].toString(),
                                valor: controller.pedido['produtos'][index]['valor'].toStringAsFixed(2),
                                id: 4,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.tertiary, borderRadius: BorderRadius.vertical(bottom: Radius.circular(5))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 22),
                              child: Row(
                                children: [
                                  Text(
                                    "Total :",
                                    style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),
                                  ),
                                  Text(
                                    " R\$ ${controller.pedido['valor_total']}",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onTertiary),
                                  ),
                                  Spacer(),
                                  RawMaterialButton(
                                    fillColor: Theme.of(context).colorScheme.onTertiaryContainer,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    padding: const EdgeInsets.all(12),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => ModalFinalizaPedido(id: controller.pedido['id']),
                                      );
                                    },
                                    child: Text(
                                      "Finalizar",
                                      style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                  }
                },
              )),
        ));
  }
}
