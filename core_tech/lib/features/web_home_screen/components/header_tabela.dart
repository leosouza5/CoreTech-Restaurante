import 'package:flutter/material.dart';

class HeaderTabela extends StatelessWidget {
  final Icon icon;
  final String titulo;
  const HeaderTabela({super.key, required this.icon, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return TableCell(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Padding(padding: const EdgeInsets.only(left: 8.0), child: titulo),
          Tooltip(padding: EdgeInsets.all(8), preferBelow: false, message: titulo, child: icon),
        ],
      ),
    ));
  }
}
