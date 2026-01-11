import "package:jaspr/dom.dart" show i, span, Styles;
import "package:jaspr/jaspr.dart" show StatelessComponent, BuildContext, Component;

import "modifier.dart";

class IconLabel extends StatelessComponent {
  final Icon icon;
  final String label;
  final bool isIconText;
  final String classes;
  const IconLabel({super.key, required this.icon, required this.label, this.classes = ""})
    : isIconText = false;
  const IconLabel.iconText({super.key, required this.icon, required this.label, this.classes = ""})
    : isIconText = true;

  @override
  Component build(BuildContext context) {
    final content = [
      icon,
      span([.text(label)]),
    ];

    if (isIconText) {
      return span(classes: "icon-text $classes", content);
    } else {
      return .fragment(content);
    }
  }
}

class Icon extends StatelessComponent {
  final String icon;
  final bool isLucide;
  final String faPrefix;
  final String classes;
  final bool ariaHidden;
  final Styles? styles;
  final Size? size;
  const Icon.fa({
    super.key,
    required this.icon,
    this.styles,
    this.size,
    this.classes = "",
    this.ariaHidden = true,
  }) : isLucide = false,
       faPrefix = "";
  const Icon.fab({
    super.key,
    required this.icon,
    this.styles,
    this.size,
    this.classes = "",
    this.ariaHidden = true,
  }) : isLucide = false,
       faPrefix = "fab fa-";
  const Icon.fas({
    super.key,
    required this.icon,
    this.styles,
    this.size,
    this.classes = "",
    this.ariaHidden = true,
  }) : isLucide = false,
       faPrefix = "fas fa-";
  const Icon.lucide({
    super.key,
    required this.icon,
    this.styles,
    this.size,
    this.classes = "",
    this.ariaHidden = true,
  }) : isLucide = true,
       faPrefix = "";

  @override
  Component build(BuildContext context) {
    if (isLucide) {
      return span(
        classes:
            "icon lucide-icon $classes"
            "${getModifier(size)}",
        styles: styles,
        [
          i(attributes: {"data-lucide": icon, "aria-hidden": "$ariaHidden"}, []),
        ],
      );
    } else {
      return span(
        classes:
            "icon fa-icon $classes"
            "${getModifier(size)}",
        styles: styles,
        [
          i(classes: "$faPrefix$icon", attributes: {"aria-hidden": "$ariaHidden"}, []),
        ],
      );
    }
  }
}
