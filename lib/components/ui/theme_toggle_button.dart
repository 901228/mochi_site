import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";
import "package:universal_web/web.dart";

import "bulma/button.dart";
import "bulma/icon.dart";

class ThemeToggleButton extends StatelessComponent {
  const ThemeToggleButton({super.key});

  @override
  Component build(BuildContext context) {
    return Button(
      child: Icon.lucide(icon: "sun"),
      styles: Styles(border: .none, shadow: .none),
      onPressed: kIsWeb
          ? () {
              final dataTheme = document.getElementById("root")?.attributes.getNamedItem("data-theme");
              if (dataTheme != null) {
                dataTheme.value = dataTheme.value == "light" ? "dark" : "light";
                document.getElementById("root")?.attributes.setNamedItem(dataTheme);
              }
            }
          : null,
    );
  }
}
