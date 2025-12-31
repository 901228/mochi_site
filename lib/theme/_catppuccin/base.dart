import "package:jaspr/dom.dart" show Color;
import "package:jaspr/jaspr.dart" show decoder, encoder;

import "../theme.dart";
import "flavors/frappe.dart";
import "flavors/latte.dart";
import "flavors/macchiato.dart";
import "flavors/mocha.dart";

typedef Flavor = ({
  Color rosewater,
  Color flamingo,
  Color pink,
  Color mauve,
  Color red,
  Color maroon,
  Color peach,
  Color yellow,
  Color green,
  Color teal,
  Color sky,
  Color sapphire,
  Color blue,
  Color lavender,
  Color text,
  Color subtext1,
  Color subtext0,
  Color overlay2,
  Color overlay1,
  Color overlay0,
  Color surface2,
  Color surface1,
  Color surface0,
  Color crust,
  Color mantle,
  Color base,
});

extension FlavorSerializer on Flavor {
  static Flavor decode(Map<String, dynamic> data) => (
    rosewater: Color(data["rosewater"]),
    flamingo: Color(data["flamingo"]),
    pink: Color(data["pink"]),
    mauve: Color(data["mauve"]),
    red: Color(data["red"]),
    maroon: Color(data["maroon"]),
    peach: Color(data["peach"]),
    yellow: Color(data["yellow"]),
    green: Color(data["green"]),
    teal: Color(data["teal"]),
    sky: Color(data["sky"]),
    sapphire: Color(data["sapphire"]),
    blue: Color(data["blue"]),
    lavender: Color(data["lavender"]),
    text: Color(data["text"]),
    subtext1: Color(data["subtext1"]),
    subtext0: Color(data["subtext0"]),
    overlay2: Color(data["overlay2"]),
    overlay1: Color(data["overlay1"]),
    overlay0: Color(data["overlay0"]),
    surface2: Color(data["surface2"]),
    surface1: Color(data["surface1"]),
    surface0: Color(data["surface0"]),
    crust: Color(data["crust"]),
    mantle: Color(data["mantle"]),
    base: Color(data["base"]),
  );

  Map<String, dynamic> encode() => {
    "rosewater": rosewater.value,
    "flamingo": flamingo.value,
    "pink": pink.value,
    "mauve": mauve.value,
    "red": red.value,
    "maroon": maroon.value,
    "peach": peach.value,
    "yellow": yellow.value,
    "green": green.value,
    "teal": teal.value,
    "sky": sky.value,
    "sapphire": sapphire.value,
    "blue": blue.value,
    "lavender": lavender.value,
    "text": text.value,
    "subtext1": subtext1.value,
    "subtext0": subtext0.value,
    "overlay2": overlay2.value,
    "overlay1": overlay1.value,
    "overlay0": overlay0.value,
    "surface2": surface2.value,
    "surface1": surface1.value,
    "surface0": surface0.value,
    "crust": crust.value,
    "mantle": mantle.value,
    "base": base.value,
  };
}

typedef Catppuccin = ({Flavor latte, Flavor frappe, Flavor macchiato, Flavor mocha});

Catppuccin catppuccin = (latte: latte, frappe: frappe, macchiato: macchiato, mocha: mocha);

class FlavorTheme {
  final Flavor light;
  final Flavor dark;
  const FlavorTheme({required this.light, required this.dark});

  @decoder
  static FlavorTheme decode(Map<String, dynamic> data) =>
      FlavorTheme(light: FlavorSerializer.decode(data["light"]), dark: FlavorSerializer.decode(data["dark"]));

  @encoder
  Map<String, dynamic> encode() => {"light": light.encode(), "dark": dark.encode()};

  Flavor get([Brightness brightness = Brightness.light]) {
    if (brightness == Brightness.light) {
      return light;
    } else {
      return dark;
    }
  }
}
