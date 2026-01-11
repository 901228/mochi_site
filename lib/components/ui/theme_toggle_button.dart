import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";

import "../../theme/theme.dart";
import "bulma/button.dart";
import "bulma/icon.dart";
import "bulma/modifier.dart" show isWebSkeleton;

class ThemeToggleButton extends StatefulComponent {
  const ThemeToggleButton({super.key});

  @override
  State createState() => ThemeToggleButtonState();
}

class ThemeToggleButtonState extends State<ThemeToggleButton> {
  late ThemeMode mode;

  @override
  void initState() {
    super.initState();
    mode = ThemeMode.current ?? .light;
  }

  @override
  Component build(BuildContext context) {
    return .fragment([
      Button(
        classes: "theme-toggle-button $isWebSkeleton",
        child: Icon.lucide(icon: "moon"),
        styles: Styles(display: mode == .light ? .flex : .none, cursor: kIsWeb ? null : .notAllowed),
        onPressed: kIsWeb
            ? () {
                setState(() {
                  ThemeMode.setDark();
                  mode = .dark;
                });
              }
            : null,
      ),
      Button(
        classes: "theme-toggle-button $isWebSkeleton",
        child: Icon.lucide(icon: "sun"),
        styles: Styles(display: mode == .dark ? .flex : .none, cursor: kIsWeb ? null : .notAllowed),
        onPressed: kIsWeb
            ? () {
                setState(() {
                  ThemeMode.setLight();
                  mode = .light;
                });
              }
            : null,
      ),
    ]);
  }

  @css
  static List<StyleRule> get styles => [css(".theme-toggle-button").styles(border: .none, shadow: .none)];
}
