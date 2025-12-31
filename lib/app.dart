import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";
import "package:jaspr_router/jaspr_router.dart";

import "components/header.dart";
import "components/portal.dart";
import "pages/portal.dart";
import "theme/catppuccin.dart";
import "theme/theme.dart";

class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return BrightnessWrapper(
      brightness: Brightness.light,
      child: CatppuccinFlavor(
        light: catppuccin.latte,
        dark: catppuccin.mocha,
        child: Builder(
          builder: (context) => div(
            classes: "main",
            styles: Styles(
              color: CatppuccinFlavor.flavor(context).text,
              backgroundColor: CatppuccinFlavor.flavor(context).base,
            ),
            [
              Header(),
              Router(
                routes: [
                  Route(
                    path: "/",
                    title: "Portal",
                    builder: (context, state) => const Portal(
                      portals: [
                        PortalItem(name: "komodo", image: "images/icons/komodo.svg", port: 9120),
                        PortalItem(name: "stashapp", image: "images/icons/stashapp.svg", port: 9999),
                        PortalItem(name: "immich", image: "images/icons/immich.svg", port: 2283),
                        PortalItem(name: "filebrowser", image: "images/icons/filebrowser.svg", port: 8001),
                        PortalItem(name: "gitea", image: "images/icons/gitea.svg", port: 3000),
                      ],
                      actions: [
                        PortalItem(
                          name: "GitHub",
                          image: "images/icons/github.svg",
                          url: "https://github.com/901228",
                        ),
                        PortalItem(
                          name: "Twitter",
                          image: "images/icons/twitter.svg",
                          url: "https://twitter.com/emlon900000",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Footer(),
            ],
          ),
        ),
      ),
    );
  }

  @css
  static List<StyleRule> get styles => [
    css(".main", [
      css("&").styles(display: .flex, width: 100.percent, height: 100.percent, flexDirection: .column),
      css("section").styles(
        display: .flex,
        flexDirection: .column,
        justifyContent: .start,
        alignItems: .center,
        flex: Flex(grow: 1),
      ),
    ]),
  ];
}
