import "package:jaspr/dom.dart" show Styles, UnitExt, i, span;
import "package:jaspr/jaspr.dart" show StatelessComponent, BuildContext, Component;

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
  const Icon.fa({super.key, required this.icon, this.classes = ""}) : isLucide = false, faPrefix = "";
  const Icon.fab({super.key, required this.icon, this.classes = ""}) : isLucide = false, faPrefix = "fab fa-";
  const Icon.fas({super.key, required this.icon, this.classes = ""}) : isLucide = false, faPrefix = "fas fa-";
  const Icon.lucide({super.key, required this.icon, this.classes = ""}) : isLucide = true, faPrefix = "";

  @override
  Component build(BuildContext context) {
    if (isLucide) {
      return span(classes: "icon lucide-icon $classes", [
        i(
          styles: Styles(width: 20.px, height: 16.px), // to align with bulma's fa settings
          attributes: {"data-lucide": icon},
          [],
        ),
      ]);
    } else {
      return span(classes: "icon fa-icon $classes", [i(classes: "$faPrefix$icon", [])]);
    }
  }
}
