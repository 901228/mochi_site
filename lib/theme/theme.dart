library;

import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";
import "package:universal_web/web.dart";

export "catppuccin.dart";
export "lucide.dart";

enum ThemeMode {
  light("catppuccin-latte"),
  dark("catppuccin-mocha");

  final String highlightTheme;
  const ThemeMode(this.highlightTheme);

  static const String themeRootId = "root";
  static const String highlightThemeId = "highlightjs-catppuccin-theme";

  static ThemeMode? get current {
    if (!kIsWeb) return null;

    final dataTheme = document.getElementById(themeRootId)?.attributes.getNamedItem("data-theme");
    if (dataTheme == null) return null;

    return dataTheme.value == light.name ? light : dark;
  }

  static bool toggle() {
    if (!kIsWeb) return false;

    if (current == light) {
      return setDark();
    } else if (current == dark) {
      return setLight();
    }

    return false;
  }

  static bool setMode(ThemeMode mode) {
    if (!kIsWeb) return false;

    // global theme
    final dataTheme = document.getElementById(themeRootId)?.getAttribute("data-theme");
    if (dataTheme == null || dataTheme == mode.name) return false;

    // highlightjs theme
    String? highlightTheme = document.getElementById(highlightThemeId)?.getAttribute("href");
    if (highlightTheme == null || highlightTheme.contains(mode.highlightTheme)) return false;

    // ignore: no_leading_underscores_for_local_identifiers
    for (final _mode in ThemeMode.values) {
      if (highlightTheme!.contains(_mode.highlightTheme)) {
        highlightTheme = highlightTheme.replaceAll(_mode.highlightTheme, mode.highlightTheme);
      }
    }

    document.getElementById(themeRootId)?.setAttribute("data-theme", mode.name);
    document.getElementById(highlightThemeId)?.setAttribute("href", highlightTheme!);
    window.localStorage.setItem("data-theme", mode.name);
    return true;
  }

  static bool setLight() => setMode(light);
  static bool setDark() => setMode(dark);
}

class CustomStyleRule implements StyleRule {
  final String raw;
  const CustomStyleRule(this.raw);

  @override
  String toCss([String indent = ""]) {
    return raw;
  }
}

abstract class BulmaColor {
  static Color get background => Color("var(--bulma-background)");
  static Color get schemeMain => Color("var(--bulma-scheme-main)");
  static Color get text => Color("var(--bulma-text)");
  static Color get linkText => Color("var(--bulma-link-text)");
  static Color get blockquoteBackground => Color("var(--bulma-content-blockquote-background-color)");
}
