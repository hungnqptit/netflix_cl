import 'package:flutter/material.dart';

extension ListWidgetExt on List<Widget> {
  List<Widget> separator(Widget Function(int index) creator) {
    if (this.length < 2) return this;
    final List<Widget> newList = List.from(this);
    final int length = this.length;
    for (var i = length - 2; i >= 0; i--) {
      newList.insert(i + 1, creator.call(i));
    }

    return newList;
  }
}
