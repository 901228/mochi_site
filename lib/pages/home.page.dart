import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";

import "../components/ui/logo.dart";

class HomePage extends StatelessComponent {
  const HomePage({super.key});

  @override
  Component build(BuildContext context) {
    return div(classes: "container has-text-centered", [
      div(classes: "is-flex is-flex-direction-column", [
        Logo(
          styles: Styles(
            maxHeight: 384.px,
            padding: .symmetric(vertical: 1.rem, horizontal: 8.rem),
          ),
        ),
        h1(classes: "title is-1 py-5", [.text("Mochi's Site")]),
      ]),
    ]);
  }
}
