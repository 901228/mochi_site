import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";
import "package:jaspr_router/jaspr_router.dart";

import "components/layout/footer.dart";
import "components/layout/header.dart";
import "pages/home.page.dart";
import "pages/portal.page.dart";

class App extends StatelessComponent {
  final List<RouteBase> routes;
  const App({super.key, required this.routes});

  @override
  Component build(BuildContext context) {
    return .fragment([
      Header(),
      div(classes: "main", [
        Router(
          routes: [
            Route(
              path: "/",
              name: "/",
              title: "Home",
              builder: (_, _) => const HomePage(),
              routes: [
                Route(
                  path: "portal",
                  name: "/portal",
                  title: "Portal",
                  builder: (_, _) => const PortalPage(
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
            ...routes,
          ],
        ),
      ]),
      Footer(),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css(".main", [
      css("&").styles(fontFamily: .list([FontFamily("Comfortaa"), FontFamilies.sansSerif])),
    ]),
  ];
}
