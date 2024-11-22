import 'package:core_tech/features/web_home_screen/controller/pedidos_controller.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../global/enum/enum.dart';
import '../../web_home_screen/components/botao_acao_rapida.dart';
import '../../web_home_screen/components/header_tabela.dart';

class OrdersResume extends StatefulWidget {
  const OrdersResume({super.key});

  @override
  State<OrdersResume> createState() => _OrdersResumeState();
}

class _OrdersResumeState extends State<OrdersResume> {
  @override
  String data = DateTime.now().toString();
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<PedidosController>().recuperarPedidosFechados(data);
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
              image: DecorationImage(image: AssetImage('assets/images/logo.webp'), fit: BoxFit.fitWidth),
            ),
          ),
        ),
        centerTitle: true,
        title: Text("Relatório de vendas"),
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
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .2,
                        child: DateTimeFormField(
                          decoration: const InputDecoration(
                            labelText: 'Selecione uma data',
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          dateFormat: DateFormat('dd/MM/yyyy'),
                          initialValue: DateTime.now(),
                          mode: DateTimeFieldPickerMode.date,
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                          onChanged: (DateTime? selectedDate) {
                            if (selectedDate != null) {
                              data = selectedDate.toString();
                              controller.recuperarPedidosFechados(data);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Builder(
                  builder: (context) {
                    switch (controller.pedidosFechadosState) {
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
                            ],
                          ),
                        );
                      case LocalState.loading:
                        return Center(child: CircularProgressIndicator());
                      case LocalState.idle:
                        return Text("asd");
                      case LocalState.sucesso:
                        return Expanded(
                          child: Table(
                            children: [
                              const TableRow(
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
                                ],
                              ),
                              ...controller.pedidosFechados.map(
                                (e) => TableRow(
                                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainer),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(16),
                                      child: TableCell(
                                        child: SizedBox(
                                          child: Center(child: Text(e['id'].toString())),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(16),
                                      child: TableCell(
                                        child: SizedBox(
                                          child: Center(child: Text(e['mesa'])),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(16),
                                      child: TableCell(
                                        child: SizedBox(
                                          child: Center(
                                            child: Text("${e['data_pedido'].substring(8, 10)}/${e['data_pedido'].substring(5, 7)}/${e['data_pedido'].substring(0, 4)}"),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(16),
                                      child: TableCell(
                                        child: SizedBox(
                                          child: Center(child: Text(e['valor_total'])),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                    }
                  },
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.tertiary, borderRadius: BorderRadius.vertical(bottom: Radius.circular(5))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 22),
                    child: Row(
                      children: [
                        Text(
                          "Numero de pedidos : ",
                          style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),
                        ),
                        Text(
                          " ${controller.pedidosFechados.length}",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onTertiary),
                        ),
                        Spacer(),
                        Text(
                          "Total :",
                          style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),
                        ),
                        Text(
                          " R\$ ${controller.valorTotal.toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onTertiary),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
