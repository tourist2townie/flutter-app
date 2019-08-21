import 'dart:async';
import 'package:tt/View%20Model/MenuViewModelGuide.dart';
import 'package:tt/models/ModelGuide.dart';

class MenuBloc {
  final _menuVM = MenuViewModelGuide();
  final menuController = StreamController<List<MenuGuide>>();

  Stream<List<MenuGuide>> get menuItemsGuide => menuController.stream;

  MenuBloc() {
    menuController.add(_menuVM.getMenuItems());
  }
}
