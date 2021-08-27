import 'package:flutter/material.dart';

class FABBottomAppBarItem {
  FABBottomAppBarItem({required this.iconData, required this.text});
  IconData iconData;
  String text;
}

class FABBottomAppBar extends StatefulWidget {
  const FABBottomAppBar({
    Key? key,
    required this.items,
    this.centerItemText,
    this.height = 60,
    this.iconSize = 24.0,
    required this.backgroundColor,
    required this.defaultColor,
    required this.selectedBarColor,
    required this.selectedColor,
    this.notchedShape,
    required this.onTabSelected,
    required this.textStyle,
  })  : assert(items.length == 2 || items.length == 4),
        super(key: key);

  final List<FABBottomAppBarItem> items;
  final String? centerItemText;
  final NotchedShape? notchedShape;
  final double height;
  final double iconSize;
  final TextStyle textStyle;
  final Color backgroundColor;
  final Color defaultColor;
  final Color? selectedBarColor;
  final Color selectedColor;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;

  void _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // Future.delayed(Duration(milliseconds: 1), () => _updateIndex(1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      color: widget.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize),
            Text(
              widget.centerItemText ?? '',
              style: widget.textStyle.copyWith(color: widget.selectedColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required FABBottomAppBarItem item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    final Color color =
        _selectedIndex == index ? widget.selectedColor : widget.defaultColor;
    final Color? barColor =
        _selectedIndex == index ? widget.selectedBarColor : Colors.transparent;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: InkWell(
          onTap: () => onPressed(index),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                    color: barColor ?? Colors.transparent, width: 4.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item.iconData, color: color, size: widget.iconSize),
                Text(
                  item.text,
                  style: widget.textStyle.copyWith(color: color),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
