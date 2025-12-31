import "package:jaspr/jaspr.dart";

import "_catppuccin/base.dart";

enum Brightness { dark, light }

class BrightnessWrapper extends InheritedComponent {
  final Brightness brightness;
  const BrightnessWrapper({super.key, required super.child, required this.brightness});

  static BrightnessWrapper of(BuildContext context) {
    final BrightnessWrapper? result = context.dependOnInheritedComponentOfExactType<BrightnessWrapper>();
    assert(result != null, "No BrightnessWrapper found in context");
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedComponent oldComponent) => true;
}

class CatppuccinFlavor extends InheritedComponent {
  final FlavorTheme _theme;
  CatppuccinFlavor({super.key, required super.child, Flavor? light, Flavor? dark, FlavorTheme? theme})
    : assert((theme != null) ^ (light != null && dark != null)),
      _theme = theme ?? FlavorTheme(light: light!, dark: dark!);

  static CatppuccinFlavor _of(BuildContext context) {
    final CatppuccinFlavor? result = context.dependOnInheritedComponentOfExactType<CatppuccinFlavor>();
    assert(result != null, "No CatppuccinFlavor found in context");
    return result!;
  }

  static Flavor flavor(BuildContext context, [Brightness? brightness]) {
    final data = CatppuccinFlavor._of(context);
    if (brightness == null) {
      try {
        brightness = BrightnessWrapper.of(context).brightness;
      } catch (_) {
        brightness = Brightness.light;
      }
    }

    return brightness == Brightness.light ? data._theme.light : data._theme.dark;
  }

  static FlavorTheme theme(BuildContext context) {
    final data = CatppuccinFlavor._of(context);
    return data._theme;
  }

  @override
  bool updateShouldNotify(CatppuccinFlavor oldWidget) {
    return true;
  }
}
