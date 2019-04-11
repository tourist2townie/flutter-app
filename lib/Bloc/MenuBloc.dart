import 'dart:async';

import 'package:tt/View Model/MenuViewModel.dart';
import 'package:tt/models/model.dart';

class MenuBloc {
  final _menuVM = MenuViewModel();
  final menuController = StreamController<List<Menu>>();

  Stream<List<Menu>> get menuItems => menuController.stream;

  MenuBloc() {
    menuController.add(_menuVM.getMenuItems());
  }
}
