import 'package:core_tech/features/food_menu/components/produto_linha.dart';
import 'package:flutter/material.dart';

class FoodMenuController extends ChangeNotifier {
  List<Widget> produtos = [
    ProdutoLinha(),
  ];

  void adiconarProdutoExtra() {
    produtos.add(ProdutoLinha());
    notifyListeners();
  }

  void removeProdutoExtra() {
    produtos.removeLast();
    notifyListeners();
  }
}
