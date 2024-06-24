import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationHelper {
  static void onItemTapped(
      BuildContext context, int index, Function(int) updateIndex) {
    updateIndex(index);
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/member');
        break;
      case 2:
        context.go('/operation');
        break;
      case 3:
        context.go('/settlement');
        break;
      case 4:
        context.go('/product');
        break;
      case 5:
        context.go('/client');
        break;
      case 6:
        context.go('/statistics');
        break;
    }
  }
}
