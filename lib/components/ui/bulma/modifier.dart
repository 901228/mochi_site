enum Color { primary, link, info, success, warning, danger }

enum ColorMode { light, dark }

enum Style { outlined, inverted, rounded }

enum State { normal, hovered, focused, active, loading, static }

enum Size { small, normal, medium, large }

extension ModifierEnum on Enum {
  String get getClass => " is-$name";
}

String getModifier(dynamic value, [String? name]) {
  if (value is Enum) {
    return value.getClass;
  } else if (value is bool && value) {
    return " $name";
  }
  return "";
}
