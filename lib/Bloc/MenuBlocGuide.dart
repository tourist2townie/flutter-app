import 'dart:async';
import 'package:tt/View%20Model/MenuViewModelGuide.dart';
import 'package:tt/models/model.dart';

class MenuBloc {
  final _menuVM = MenuViewModelGuide();
  final menuController = StreamController<List<Menu>>();

  Stream<List<Menu>> get menuItemsGuide => menuController.stream;

  MenuBloc() {
    menuController.add(_menuVM.getMenuItems());
  }
}
