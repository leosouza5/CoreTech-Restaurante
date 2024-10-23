import 'package:core_tech/features/food_menu/controller/food_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../web_home_screen/components/botao_acao_rapida.dart';

class FoodMenu extends StatelessWidget {
  const FoodMenu({super.key});

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
              child: ListView(
                children: [
                  SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
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
                  RawMaterialButton(
                    shape: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.surfaceContainerHighest),
                    ),
                    padding: const EdgeInsets.all(12),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Text("Cardápio Príncipal"),
                        Icon(Icons.star_outline),
                      ],
                    ),
                  ),
                  RawMaterialButton(
                    shape: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.surfaceContainerHighest),
                    ),
                    padding: const EdgeInsets.all(12),
                    onPressed: () {},
                    child: Text("Cardápio Alternativo"),
                  ),
                  RawMaterialButton(
                    shape: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.surfaceContainerHighest),
                    ),
                    padding: const EdgeInsets.all(12),
                    onPressed: () {},
                    child: Text("Cardápio de Natal"),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                ),
                child: ListView(
                  children: [
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        "Cardápio Principal",
                        style: TextStyle(fontSize: 24),
                      ),
                    )),
                    Divider(),
                    Column(children: controller.produtos),
                    Align(
                      child: ElevatedButton(
                        onPressed: () {
                          controller.adiconarProdutoExtra();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                        ),
                        child: Icon(
                          Icons.add,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
