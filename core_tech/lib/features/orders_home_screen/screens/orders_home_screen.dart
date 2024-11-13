import 'package:core_tech/features/orders_home_screen/controllers/orders_controller.dart';
import 'package:core_tech/global/enum/enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'new_order.dart';

class OrdersHomeScreen extends StatefulWidget {
  const OrdersHomeScreen({super.key});

  @override
  State<OrdersHomeScreen> createState() => _OrdersHomeScreenState();
}

class _OrdersHomeScreenState extends State<OrdersHomeScreen> {
  @override
  void initState() {
    context.read<OrdersController>().recuperaPedidos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OrdersController>();
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
        actions: [
          RawMaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(12),
            onPressed: () {
              controller.recuperaPedidos();
            },
            child: const Icon(Icons.refresh),
          ),
        ],
        title: Text("CoreTech"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewOrder(
                edicao: false,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Pedidos abertos",
              style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 28),
            ),
          ),
          Divider(),
          Builder(
            builder: (context) {
              switch (controller.pedidosState) {
                case LocalState.loading:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case LocalState.error:
                  return Center(child: Text(controller.erro));
                case LocalState.idle:
                  return Container();
                case LocalState.sucesso:
                  return Expanded(
                    child: ListView.builder(
                      itemCount: controller.pedidos.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(10)),
                            tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                            title: Text("Pedido ${controller.pedidos[index]['id']}"),
                            subtitle: Text("Mesa ${controller.pedidos[index]['mesa']}"),
                            trailing: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewOrder(
                                        edicao: true,
                                        idPedido: controller.pedidos[index]['id'],
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.visibility)),
                          ),
                        );
                      },
                    ),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
