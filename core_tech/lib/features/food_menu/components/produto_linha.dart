import 'package:flutter/material.dart';

import '../../../global/components/input.dart';

class ProdutoLinha extends StatelessWidget {
  const ProdutoLinha({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(children: [
          Expanded(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/images/comida.jpg',
                      height: 90,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Input(label: Text("Produto")),
                    )),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Input(label: Text("Descricão")),
                    )),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Input(label: Text("Valor")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RawMaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(12),
                    onPressed: () {},
                    child: Icon(Icons.delete),
                  ),
                )
              ],
            ),
          )
        ]));
  }
}
