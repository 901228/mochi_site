import "package:jaspr/dom.dart" show a, button, div, Styles;
import "package:jaspr/jaspr.dart" show StatelessComponent, Component, VoidCallback, BuildContext;

import "modifier.dart";

/// Bulma Button Component
/// Supports a limited subset of the available options
/// See https://bulma.io/documentation/elements/button/ for a detailed description
class Button extends StatelessComponent {
  const Button({
    super.key,
    required this.child,
    required this.onPressed,
    this.styles,
    this.color,
    this.colorMode,
    this.style,
    this.state,
    this.size,
    this.isBlock = false,
    this.isDisabled = false,
    this.classes = "",
  }) : isA = false,
       href = null;
  const Button.a({
    super.key,
    required this.child,
    required this.href,
    this.styles,
    this.color,
    this.colorMode,
    this.style,
    this.state,
    this.size,
    this.isBlock = false,
    this.isDisabled = false,
    this.classes = "",
  }) : isA = true,
       onPressed = null;

  final Component child;
  final VoidCallback? onPressed;
  final String? href;
  final Styles? styles;
  final Color? color;
  final ColorMode? colorMode;
  final Style? style;
  final State? state;
  final Size? size;
  final bool isBlock;
  final bool isDisabled;
  final String classes;

  final bool isA;

  @override
  Component build(BuildContext context) {
    final String cls =
        "button"
        "${getModifier(color)}"
        "${getModifier(colorMode)}"
        "${getModifier(style)}"
        "${getModifier(state)}"
        "${getModifier(size)}"
        "${getModifier(isBlock, "block")}"
        " $classes";

    if (isA) {
      return a(classes: cls, href: href!, styles: styles, [child]);
    } else {
      return button(classes: cls, disabled: isDisabled, onClick: onPressed, styles: styles, [child]);
    }
  }
}

/// Bulma Button Group Component
class ButtonGroup extends StatelessComponent {
  const ButtonGroup({required this.children, this.isAttached = false, super.key});

  final List<Button> children;
  final bool isAttached;

  @override
  Component build(BuildContext context) {
    return div(
      classes:
          "buttons block"
          "${getModifier(isAttached, "has-addons")}",
      children,
    );
  }
}
