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
            maxHeight: 40.vh,
            padding: .symmetric(vertical: 1.em, horizontal: 8.em),
          ),
        ),
        h1(classes: "title is-1 py-5", [.text("Mochi's Site")]),
      ]),
    ]);
  }
}
