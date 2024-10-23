import 'package:flutter/material.dart';

class BotaoAcaoRapida extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final Icon icon;
  const BotaoAcaoRapida({super.key, this.onPressed, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: RawMaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(12),
          onPressed: onPressed ?? () {},
          child: Row(
            children: [Text(label), SizedBox(width: 15), icon],
          )),
    );
  }
}
