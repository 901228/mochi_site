import "flavors/frappe.dart";
import "flavors/latte.dart";
import "flavors/macchiato.dart";
import "flavors/mocha.dart";

class Color {
  final int hue;
  final int saturation;
  final int lightness;
  const Color(this.hue, this.saturation, this.lightness);

  int get h => hue;
  int get s => saturation;
  int get l => lightness;

  static double _hue2rgb(double p, double q, double t) {
    if (t < 0.0) {
      t += 1.0;
    }
    if (t > 1) {
      t -= 1.0;
    }
    if (t < 1.0 / 6.0) {
      return p + (q - p) * 6.0 * t;
    }
    if (t < 1.0 / 2.0) {
      return q;
    }
    if (t < 2.0 / 3.0) {
      return p + (q - p) * (2.0 / 3.0 - t) * 6.0;
    }
    return p;
  }

  (double q, double p) _qp(double h, double s, double l) {
    final q = l < 0.5 ? l * (1.0 + s) : l + s - l * s;
    final p = 2.0 * l - q;
    return (q, p);
  }

  int get r {
    double h = hue / 360.0;
    double s = saturation / 100.0;
    double l = lightness / 100.0;

    if (s == 0) {
      return (l * 255.0).round();
    }

    final (q, p) = _qp(h, s, l);
    final r = _hue2rgb(p, q, h + 1.0 / 3.0);
    return (r * 255.0).round();
  }

  int get g {
    double h = hue / 360.0;
    double s = saturation / 100.0;
    double l = lightness / 100.0;

    if (s == 0) {
      return (l * 255.0).round();
    }

    final (q, p) = _qp(h, s, l);
    final g = _hue2rgb(p, q, h);
    return (g * 255.0).round();
  }

  int get b {
    double h = hue / 360.0;
    double s = saturation / 100.0;
    double l = lightness / 100.0;

    if (s == 0) {
      return (l * 255.0).round();
    }

    final (q, p) = _qp(h, s, l);
    final b = _hue2rgb(p, q, h - 1.0 / 3.0);
    return (b * 255.0).round();
  }

  (int r, int g, int b) get rgb {
    double h = hue / 360.0;
    double s = saturation / 100.0;
    double l = lightness / 100.0;

    if (s == 0) {
      final gray = (l * 255.0).round();
      return (gray, gray, gray);
    }

    final (q, p) = _qp(h, s, l);

    final r = _hue2rgb(p, q, h + 1.0 / 3.0);
    final g = _hue2rgb(p, q, h);
    final b = _hue2rgb(p, q, h - 1.0 / 3.0);

    return ((r * 255.0).round(), (g * 255.0).round(), (b * 255.0).round());
  }

  String get hex {
    // ignore: no_leading_underscores_for_local_identifiers
    final (_r, _g, _b) = rgb;
    return "${_r.toRadixString(16).padLeft(2, '0')}${_g.toRadixString(16).padLeft(2, '0')}${_b.toRadixString(16).padLeft(2, '0')}";
  }

  @override
  String toString() {
    return "Color(hue: ${hue}deg, saturation: $saturation%, lightness: $lightness%)";
  }
}

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

typedef Catppuccin = ({Flavor latte, Flavor frappe, Flavor macchiato, Flavor mocha});

Catppuccin catppuccin = (latte: latte, frappe: frappe, macchiato: macchiato, mocha: mocha);
