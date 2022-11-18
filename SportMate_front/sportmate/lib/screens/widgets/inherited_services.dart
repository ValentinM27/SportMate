import 'package:flutter/material.dart';
import 'package:sportmate/logic/service.dart';

class InheritedServices extends InheritedWidget {
  final Service services;

  const InheritedServices({Key? key, required this.services, required Widget child}) : super(key: key, child : child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static InheritedServices of(BuildContext context) {
    final InheritedServices? result = context.dependOnInheritedWidgetOfExactType<InheritedServices>();
    assert(result != null, "No InheritedServices found in context");
    return result!;
  }
}