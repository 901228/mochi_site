import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";

import "../theme/theme.dart";

class CircularProgressIndicator extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return div(
      classes: "spinner",
      styles: Styles(
        minWidth: 40.px,
        minHeight: 40.px,
        border: .only(
          top: BorderSide(width: 4.px, color: CatppuccinFlavor.flavor(context).sky),
          bottom: BorderSide(width: 4.px, color: CatppuccinFlavor.flavor(context).surface0),
          right: BorderSide(width: 4.px, color: CatppuccinFlavor.flavor(context).surface0),
          left: BorderSide(width: 4.px, color: CatppuccinFlavor.flavor(context).surface0),
        ),
        radius: .circular(50.percent),
        animation: Animation(name: "spin", duration: 1.seconds, count: 20), // FIXME: infinite animation?
      ),
      [],
    );
  }

  @css
  static List<StyleRule> get styles => [
    .keyframes(
      name: "spin",
      styles: {
        "0%": Styles(transform: .rotate(0.deg)),
        "100%": Styles(transform: .rotate(360.deg)),
      },
    ),
  ];
}
