import "package:jaspr/dom.dart" show progress;
import "package:jaspr/jaspr.dart" show StatelessComponent, Component, BuildContext;

import "modifier.dart";

/// Bulma Progress Bar Component
/// Supports a limited subset of the available options
/// See https://bulma.io/documentation/elements/progress/ for a detailed description
class ProgressBar extends StatelessComponent {
  const ProgressBar({super.key, this.value, this.max = 100, this.color, this.size});

  final double? value;
  final double max;
  final Color? color;
  final Size? size;

  @override
  Component build(BuildContext context) {
    return progress(
      classes:
          "progress"
          "${getModifier(color)}"
          "${getModifier(size)}",
      value: value,
      max: max,
      [],
    );
  }
}
