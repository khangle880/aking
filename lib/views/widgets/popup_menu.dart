import 'dart:ui';
import 'package:aking/views/widgets/popup_menu_item.dart';
import 'package:flutter/material.dart';

class CustomPopupMenuButton extends StatefulWidget {
  final Widget child;
  final double menuItemExtent;
  final double? menuWidth;
  final List<CustomPopupMenuItem> menuItems;
  final bool animateMenuItems;
  final BoxDecoration? menuBoxDecoration;
  final Function onPressed;
  final Duration duration;
  final double blurSize;
  final Color blurBackgroundColor;
  final Offset? offset;
  final bool enableChildInPopup;
  final double bottomOffsetHeight;
  final double menuOffset;
  final bool openWithTap;

  const CustomPopupMenuButton({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.menuItems,
    this.duration = const Duration(milliseconds: 100),
    this.menuBoxDecoration,
    this.menuItemExtent = 50.0,
    this.animateMenuItems = true,
    this.blurSize = 4,
    this.blurBackgroundColor = Colors.black,
    this.menuWidth,
    this.bottomOffsetHeight = 0,
    this.menuOffset = 0,
    this.openWithTap = false,
    this.offset,
    this.enableChildInPopup = true,
  }) : super(key: key);

  @override
  _CustomPopupMenuButtonState createState() => _CustomPopupMenuButtonState();
}

class _CustomPopupMenuButtonState extends State<CustomPopupMenuButton> {
  GlobalKey containerKey = GlobalKey();
  Offset childOffset = Offset(0, 0);
  Size? childSize;

  void getOffset() {
    final RenderBox renderBox =
        // ignore: cast_nullable_to_non_nullable
        containerKey.currentContext!.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    setState(() {
      childOffset = widget.offset ?? Offset(offset.dx, offset.dy);
      childSize = size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        key: containerKey,
        onTap: () async {
          widget.onPressed();
          if (widget.openWithTap) {
            await openMenu(context);
          }
        },
        onLongPress: () async {
          if (!widget.openWithTap) {
            await openMenu(context);
          }
        },
        child: widget.child);
  }

  Future openMenu(BuildContext context) async {
    getOffset();
    await Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: widget.duration,
            pageBuilder: (context, animation, secondaryAnimation) {
              animation = Tween(begin: 0.0, end: 1.0).animate(animation);
              return FadeTransition(
                  opacity: animation,
                  child: MenuDetails(
                    itemExtent: widget.menuItemExtent,
                    menuBoxDecoration: widget.menuBoxDecoration,
                    childOffset: childOffset,
                    childSize: childSize,
                    menuItems: widget.menuItems,
                    blurSize: widget.blurSize,
                    menuWidth: widget.menuWidth,
                    blurBackgroundColor: widget.blurBackgroundColor,
                    animateMenu: widget.animateMenuItems,
                    bottomOffsetHeight: widget.bottomOffsetHeight,
                    menuOffset: widget.menuOffset,
                    enableChildInPopup: widget.enableChildInPopup,
                    child: widget.child,
                  ));
            },
            fullscreenDialog: true,
            opaque: false));
  }
}

class MenuDetails extends StatelessWidget {
  final List<CustomPopupMenuItem> menuItems;
  final BoxDecoration? menuBoxDecoration;
  final Offset childOffset;
  final double itemExtent;
  final Size? childSize;
  final Widget child;
  final bool animateMenu;
  final double blurSize;
  final double? menuWidth;
  final Color blurBackgroundColor;
  final double? bottomOffsetHeight;
  final double? menuOffset;
  final bool enableChildInPopup;

  const MenuDetails(
      {Key? key,
      required this.menuItems,
      required this.child,
      required this.childOffset,
      required this.childSize,
      required this.menuBoxDecoration,
      required this.itemExtent,
      required this.animateMenu,
      required this.blurSize,
      required this.blurBackgroundColor,
      required this.menuWidth,
      this.bottomOffsetHeight,
      this.menuOffset,
      required this.enableChildInPopup})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final maxMenuHeight = size.height * 0.45;
    final listHeight = menuItems.length * itemExtent;

    final maxMenuWidth = menuWidth ?? (size.width * 0.70);
    final menuHeight = listHeight < maxMenuHeight ? listHeight : maxMenuHeight;
    final leftOffset = (childOffset.dx + maxMenuWidth) < size.width
        ? childOffset.dx
        : (childOffset.dx - maxMenuWidth + childSize!.width);
    final topOffset = (childOffset.dy + menuHeight + childSize!.height) <
            size.height - bottomOffsetHeight!
        ? childOffset.dy + childSize!.height + menuOffset!
        : childOffset.dy - menuHeight - menuOffset!;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurSize, sigmaY: blurSize),
              child: Container(
                color: blurBackgroundColor,
              ),
            ),
          ),
          Positioned(
            top: topOffset,
            left: leftOffset,
            child: TweenAnimationBuilder(
              duration: Duration(milliseconds: 200),
              builder: (BuildContext context, double value, Widget? child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              tween: Tween(begin: 0.0, end: 1.0),
              child: Container(
                width: maxMenuWidth,
                height: menuHeight,
                decoration: menuBoxDecoration ??
                    BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black38,
                              blurRadius: 10,
                              spreadRadius: 1)
                        ]),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: ListView.builder(
                    itemCount: menuItems.length,
                    padding: EdgeInsets.zero,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final CustomPopupMenuItem item = menuItems[index];
                      final Widget listItem = GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            item.onPressed();
                          },
                          child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(bottom: 1),
                              color: item.backgroundColor,
                              height: itemExtent,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 14),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    item.title,
                                    if (item.trailingIcon != null) ...[
                                      item.trailingIcon!
                                    ]
                                  ],
                                ),
                              )));
                      if (animateMenu) {
                        return TweenAnimationBuilder(
                            builder: (context, double value, child) {
                              return Transform(
                                transform: Matrix4.rotationX(1.5708 * value),
                                alignment: Alignment.bottomCenter,
                                child: child,
                              );
                            },
                            tween: Tween(begin: 1.0, end: 0.0),
                            duration: Duration(milliseconds: index * 200),
                            child: listItem);
                      } else {
                        return listItem;
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          if (enableChildInPopup)
            Positioned(
                top: childOffset.dy,
                left: childOffset.dx,
                child: AbsorbPointer(
                    child: SizedBox(
                  width: childSize!.width,
                  height: childSize!.height,
                  child: child,
                ))),
        ],
      ),
    );
  }
}
