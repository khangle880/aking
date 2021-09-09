import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

typedef RemovedItemBuilder<T> = Widget Function(
    BuildContext context, T item, Animation<double> animation);

class AnimatedListModel<E> extends Equatable {
  AnimatedListModel({
    required this.listKey,
    required this.removedItemBuilder,
    Iterable<E>? initialItems,
  }) : _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final RemovedItemBuilder<E> removedItemBuilder;
  final List<E> _items;

  AnimatedListState? get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList!.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList!.removeItem(
        index,
        (BuildContext context, Animation<double> animation) {
          return removedItemBuilder(context, removedItem, animation);
        },
      );
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  void operator []=(int index, E value) => _items[index] = value;

  int indexOf(E item) => _items.indexOf(item);

  List<E> get items => _items;

  @override
  List<Object?> get props => [_items, listKey, removedItemBuilder];

  AnimatedListModel<E> copyWith({
    GlobalKey<AnimatedListState>? listKey,
    RemovedItemBuilder<E>? removedItemBuilder,
    List<E>? items,
  }) {
    return AnimatedListModel<E>(
      listKey: listKey ?? this.listKey,
      removedItemBuilder: removedItemBuilder ?? this.removedItemBuilder,
      initialItems: items ?? _items,
    );
  }
}
