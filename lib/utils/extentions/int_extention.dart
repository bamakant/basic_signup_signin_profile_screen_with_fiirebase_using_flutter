import 'package:flutter/material.dart';

extension IntExntension on int? {
  int increment() => this! + 1;

  int decrement() => this! - 1;

  /// Leaves given height of space
  Widget get height => SizedBox(height: this?.toDouble());

  /// Leaves given width of space
  Widget get width => SizedBox(width: this?.toDouble());
}