import 'package:flutter/material.dart';

class MenuItem {
  final String label;
  final IconData icon;

  MenuItem({
    this.label,
    this.icon,
  });
}

class DropdownMenu extends StatefulWidget {
  final List<MenuItem> items;
  final ValueChanged<MenuItem> onSelect;
  DropdownMenu({
    this.items,
    this.onSelect,
  });
  @override
  State<StatefulWidget> createState() {
    return DropdownMenuState();
  }
}

class DropdownMenuState extends State<DropdownMenu> {
  List<DropdownMenuItem<MenuItem>> _dropDownMenuItems;

  @override
  void initState() {
    _dropDownMenuItems = buildAndGetDropDownMenuItems(widget.items);
    super.initState();
  }

  List<DropdownMenuItem<MenuItem>> buildAndGetDropDownMenuItems(
    List<MenuItem> items,
  ) {
    final _items = <DropdownMenuItem<MenuItem>>[];

    for (var item in items) {
      _items.add(
        DropdownMenuItem(
            value: item,
            child: Row(
              children: <Widget>[
                Icon(item.icon),
                const SizedBox(width: 10),
                Text(item.label),
              ],
            )),
      );
    }

    return _items;
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).primaryColorDark;

    return Container(
      child: DropdownButton(
        icon: Icon(
          Icons.more_vert,
          color: iconColor,
        ),
        underline: Container(),
        items: _dropDownMenuItems,
        onChanged: (MenuItem item) => setState(() => widget.onSelect(item)),
      ),
    );
  }
}
