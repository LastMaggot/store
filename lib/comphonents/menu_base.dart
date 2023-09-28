import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef MenuItemKeyType = String;

class Menu extends StatefulWidget {
  final List<MenuProp> items;
  final bool? collapsed;
  final ValueChanged<MenuItemKeyType>? onSelect;

  const Menu({super.key, this.onSelect, this.collapsed, required this.items});
  @override
  State<StatefulWidget> createState() {
    return _MenuState();
  }
}

class _MenuState extends State<Menu> {
  bool _opened = true;
  MenuItemKeyType? selectKey;

  void toggleOpen() {
    setState(() {
      _opened = !_opened;
    });
  }

  void onSelect(MenuItemKeyType selectKey) {
    setState(() {
      this.selectKey = selectKey;
    });
    if (widget.onSelect != null) {
      widget.onSelect!(selectKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MenuWidget(
      menuModel: MenuModel(
          onSelect: onSelect,
          collapsed: widget.collapsed,
          items: widget.items,
          opened: _opened,
          toggleOpen: toggleOpen,
          selectKey: selectKey),
      child: const _MenuLayout(),
    );
  }
}

class _MenuLayout extends StatelessWidget {
  const _MenuLayout();

  Widget _buildMenuItem(MenuProp menuProp, BuildContext context) {
    bool opened = MenuWidget.of(context).menuModel.opened;
    if (menuProp.children != null && menuProp.children!.isNotEmpty && !opened) {
      return _PopupSubMenu(key: Key(menuProp.key), menuProp: menuProp);
    } else if (menuProp.children != null &&
        menuProp.children!.isNotEmpty &&
        opened) {
      return _SubMenu(key: Key(menuProp.key), menuProp: menuProp);
    }
    return _MenuItem(key: Key(menuProp.key), menuProp: menuProp);
  }

  @override
  Widget build(BuildContext context) {
    Widget menusChildren;
    bool? collapsed = MenuWidget.of(context).menuModel.collapsed;
    bool opened = MenuWidget.of(context).menuModel.opened;
    VoidCallback toggleOpen = MenuWidget.of(context).menuModel.toggleOpen;
    List<MenuProp> items = MenuWidget.of(context).menuModel.items;

    if (collapsed != null && collapsed) {
      menusChildren = Column(
        children: [
          IconButton(
            onPressed: toggleOpen,
            icon: opened ? const Icon(Icons.menu_open) : const Icon(Icons.menu),
          ),
          const Divider(height: 2),
          Expanded(
            child: ListView(
              children:
              items.map((item) => _buildMenuItem(item, context)).toList(),
            ),
          )
        ],
      );
    } else {
      menusChildren = ListView(
        children: items.map((item) => _buildMenuItem(item, context)).toList(),
      );
    }
    return Drawer(
      width: opened ? 300 : 100,
      child: menusChildren,
    );
  }
}

class _SubMenu extends StatelessWidget {
  const _SubMenu({super.key, required this.menuProp});
  final MenuProp menuProp;

  @override
  Widget build(BuildContext context) {
    List<_MenuItem> children =
    menuProp.children!.map((it) => _MenuItem(menuProp: it)).toList();
    Color primaryColor = Theme.of(context).primaryColor;

    return ExpansionTile(
      title: Text(menuProp.label),
      leading: menuProp.icon,
      iconColor: primaryColor,
      textColor: primaryColor,
      tilePadding: const EdgeInsets.only(left: 0),
      childrenPadding: const EdgeInsets.only(left: 40),
      children: children,
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({super.key, required this.menuProp});
  final MenuProp menuProp;

  @override
  Widget build(BuildContext context) {
    MenuItemKeyType? selectKey = MenuWidget.of(context).menuModel.selectKey;
    ValueChanged<MenuItemKeyType>? onSelect =
        MenuWidget.of(context).menuModel.onSelect;
    bool opened = MenuWidget.of(context).menuModel.opened;
    Color primaryColor = Theme.of(context).primaryColor;
    // Theme.of(context).accentColor
    return ListTile(
      title: opened ? Text(menuProp.label) : menuProp.icon,
      leading: opened ? menuProp.icon : null,
      textColor:
      selectKey != null && selectKey == menuProp.key ? primaryColor : null,
      iconColor:
      selectKey != null && selectKey == menuProp.key ? primaryColor : null,
      contentPadding: const EdgeInsets.only(left: 0),
      onTap: () => {if (onSelect != null) onSelect(menuProp.key)},
    );
  }
}

class _PopupSubMenu extends StatelessWidget {
  const _PopupSubMenu({super.key, required this.menuProp});
  final MenuProp menuProp;

  @override
  Widget build(BuildContext context) {
    ValueChanged<MenuItemKeyType>? onSelect =
        MenuWidget.of(context).menuModel.onSelect;
    MenuItemKeyType? selectKey = MenuWidget.of(context).menuModel.selectKey;
    Color primaryColor = Theme.of(context).primaryColor;
    return PopupMenuButton(
      icon: menuProp.icon,
      tooltip: "展开",
      offset: const Offset(100, 0),
      onSelected: (key) => {if (onSelect != null) onSelect(key)},
      itemBuilder: (BuildContext context) => menuProp.children!
          .map((item) => PopupMenuItem(
        value: item.key,
        child: Text(item.label,
            style: selectKey == item.key
                ? TextStyle(color: primaryColor)
                : null),
      ))
          .toList(),
    );
  }
}

class MenuProp {
  //显示完整标题
  String label;
  MenuItemKeyType key;
  Icon? icon;
  bool? disabled = false;
  //收缩时的短标题
  String? title;
  List<MenuProp>? children;

  MenuProp(
      {required this.label,
        required this.key,
        this.icon,
        this.disabled,
        this.title,
        this.children});
}

class MenuModel {
  final MenuItemKeyType? selectKey;
  final ValueChanged<MenuItemKeyType>? onSelect;
  final bool? collapsed;
  bool opened;
  final List<MenuProp> items;

  VoidCallback toggleOpen;

  MenuModel({
    this.selectKey,
    this.onSelect,
    this.collapsed,
    required this.opened,
    required this.items,
    required this.toggleOpen,
  });
}

class MenuWidget extends InheritedWidget {
  const MenuWidget({
    super.key,
    required this.menuModel,
    required super.child,
  });

  final MenuModel menuModel;

  static MenuWidget? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MenuWidget>();
  }

  static MenuWidget of(BuildContext context) {
    final MenuWidget? result = maybeOf(context);
    assert(result != null, 'No MenuWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(MenuWidget oldWidget) {
    bool shouldNotify = menuModel.opened != oldWidget.menuModel.opened ||
        menuModel.selectKey != oldWidget.menuModel.selectKey ||
        menuModel.collapsed != oldWidget.menuModel.collapsed;
    return shouldNotify;
  }
}

