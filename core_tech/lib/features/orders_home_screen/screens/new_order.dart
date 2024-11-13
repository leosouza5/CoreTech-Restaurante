import 'package:core_tech/features/orders_home_screen/components/modal_confirma_criacao_pedido.dart';
import 'package:core_tech/features/orders_home_screen/screens/product_list.dart';
import 'package:core_tech/global/components/dropdown.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../controllers/orders_controller.dart';

class NewOrder extends StatefulWidget {
  final bool edicao;
  final int? idPedido;
  const NewOrder({super.key, required this.edicao, this.idPedido});

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  @override
  void initState() {
    context.read<OrdersController>().reset();
    if (widget.edicao) {
      context.read<OrdersController>().recuperaProdutosDoPedido(widget.idPedido!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OrdersController>();
    print(controller.listaProdutosDoPedido);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        centerTitle: true,
        title: Text("Novo pedido"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14),
                  child: DropDown(
                    onChanged: (v) {
                      controller.mesa = v!;
                    },
                    value: controller.mesa,
                    label: Text("Mesa"),
                    items: [
                      DropdownMenuItem(child: Text("01"), value: "01"),
                      DropdownMenuItem(child: Text("02"), value: "02"),
                      DropdownMenuItem(child: Text("03"), value: "03"),
                      DropdownMenuItem(child: Text("04"), value: "04"),
                      DropdownMenuItem(child: Text("05"), value: "05"),
                      DropdownMenuItem(child: Text("06"), value: "06"),
                      DropdownMenuItem(child: Text("07"), value: "07"),
                      DropdownMenuItem(child: Text("08"), value: "08"),
                      DropdownMenuItem(child: Text("09"), value: "09"),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.listaProdutosDoPedido.length,
                    itemBuilder: (context, index) => ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                        tileColor: index % 2 == 0 ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.surfaceContainerHighest,
                        onTap: () {},
                        title: Text(
                          controller.listaProdutosDoPedido[index]['nome'],
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "R\$ ${controller.listaProdutosDoPedido[index]['valor']}",
                                  style: TextStyle(fontSize: 22),
                                ),
                                Text(
                                  "x${controller.listaProdutosDoPedido[index]['quantidade']}",
                                  style: TextStyle(fontSize: 22),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              controller.removeProdutoDoPedido(index);
                            },
                            icon: Icon(Icons.delete))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductList(),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                    ),
                    child: Text(
                      "Adicionar produto",
                      style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.tertiary),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 22),
              child: Row(
                children: [
                  Text(
                    "Total :",
                    style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),
                  ),
                  Text(
                    " R\$ ${controller.valorTotal.toStringAsFixed(2)}",
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
                        builder: (context) => ModalConfirmaCriacaoPedido(
                          edicao: widget.edicao,
                          idPedido: widget.idPedido,
                        ),
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
      ),
    );
  }
}
