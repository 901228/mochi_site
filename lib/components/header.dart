import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";

import "../theme/theme.dart";

class Header extends StatelessComponent {
  final VoidCallback? onToggleTheme;
  const Header({super.key, this.onToggleTheme});

  @override
  Component build(BuildContext context) {
    return header(styles: Styles(backgroundColor: CatppuccinFlavor.flavor(context).crust.withOpacity(0.8)), [
      div(classes: "leading toolbox", []),
      div(classes: "middle toolbox", [.text("Mochi Portal")]),
      div(classes: "trailing toolbox", [
        // button(onClick: onToggleTheme, [
        //   i(attributes: {"data-lucide": "sun"}, []),
        // ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css("header", [
      css("&").styles(
        display: .flex,
        position: .sticky(top: 0.px, left: 0.px),
        zIndex: ZIndex(10),
        minHeight: 3.6.em,
        padding: .symmetric(horizontal: 0.5.em),
        backdropFilter: .blur(8.px),
        flexDirection: .row,
        justifyContent: .spaceBetween,
        alignItems: .center,
        alignContent: .center,
      ),

      css(".middle").styles(
        position: .absolute(top: 0.px, left: 0.px),
        width: 100.percent,
        height: 100.percent,
        justifyContent: .center,
        fontSize: 2.em,
      ),

      css(".toolbox").styles(display: .flex, flexDirection: .row, alignItems: .center),

      css("button", [
        css("&").styles(border: .none, color: .unset, backgroundColor: .unset),
        css("&:hover").styles(cursor: .pointer, color: const Color("#0005")),
      ]),
    ]),
  ];
}
