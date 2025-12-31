import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";

import "../components/portal.dart";
import "../theme/theme.dart";

class Portal extends StatelessComponent {
  final List<PortalItem> portals;
  final List<PortalItem> actions;
  const Portal({super.key, this.portals = const [], this.actions = const []});

  @override
  Component build(BuildContext context) {
    return section(
      styles: Styles(
        display: Display.flex,
        flexDirection: FlexDirection.column,
        justifyContent: JustifyContent.start,
        alignContent: AlignContent.center,
      ),
      [
        div([
          AvatarCard(title: "Mochi Portal", image: "images/avatar.png", actions: actions),
          ...portals.map(
            (portal) => PortalCard(portal: portal, flavorTheme: CatppuccinFlavor.theme(context)),
          ),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css(".portal-card", [
      css("&").styles(
        display: .flex,
        height: 200.px,
        minWidth: 400.px,
        maxWidth: 600.px,
        margin: .all(1.em),
        radius: .circular(1.em),
        flexDirection: .column,
        justifyContent: .spaceEvenly,
        alignItems: .center,
      ),
    ]),
    css(".zoomable", [
      css("&").styles(
        transition: Transition("transform", duration: Duration(milliseconds: 120), curve: .easeOut),
      ),
      css("&:hover").styles(
        transition: Transition("transform", duration: Duration(milliseconds: 120), curve: .easeOut),
        transform: .scale(1.1),
      ),
    ]),
  ];
}
