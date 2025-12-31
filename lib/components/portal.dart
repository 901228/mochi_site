import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";
import "package:universal_web/web.dart" as web;

import "../theme/catppuccin.dart";
import "../theme/theme.dart";
import "circular_progreess_indicator.dart";

class PortalItem {
  final String name;
  final String image;
  final String? _url;
  final int? port;
  const PortalItem({required this.name, required this.image, String? url, this.port})
    : assert((url != null) ^ (port != null)),
      _url = url;

  String? get url =>
      _url ?? (kIsWeb ? "${web.window.location.protocol}//${web.window.location.hostname}:$port" : null);

  @decoder
  static PortalItem decode(Map<String, dynamic> data) =>
      PortalItem(name: data["name"], image: data["image"], url: data["url"], port: data["port"]);

  @encoder
  Map<String, dynamic> encode() => {"name": name, "image": image, "url": url, "port": port};
}

class AvatarCard extends StatelessComponent {
  final String title;
  final String image;
  final List<PortalItem> actions;
  const AvatarCard({super.key, required this.title, required this.image, this.actions = const []});

  @override
  Component build(BuildContext context) {
    return div(
      classes: "portal-card",
      styles: Styles(
        position: .relative(),
        border: Border.all(color: CatppuccinFlavor.flavor(context).sky, width: 2.px),
        color: CatppuccinFlavor.flavor(context).text,
        backgroundColor: CatppuccinFlavor.flavor(context).mantle,
      ),
      [
        div(
          styles: Styles(
            display: .flex,
            width: 100.percent,
            height: 100.percent,
            flexDirection: .row,
            justifyContent: .center,
            alignItems: .center,
            gap: .column(0.5.em),
          ),
          [
            img(
              src: image,
              width: 72,
              styles: Styles(radius: .circular(100.percent)),
            ),
            p(styles: Styles(fontSize: 2.6.em), [.text(title)]),
          ],
        ),
        div(
          styles: Styles(
            display: .flex,
            position: .absolute(left: 0.px, bottom: 0.5.em),
            width: 100.percent,
            flexDirection: .row,
            justifyContent: .center,
            alignItems: .center,
            gap: .column(0.5.em),
          ),
          actions.map((action) {
            final url = action.url;
            return a(href: url ?? "", styles: Styles(pointerEvents: url == null ? .none : null), [
              img(src: action.image, alt: action.name, classes: "zoomable", width: 36),
            ]);
          }).toList(),
        ),
      ],
    );
  }
}

@client
class PortalCard extends StatelessComponent {
  final PortalItem portal;
  final FlavorTheme? flavorTheme;
  const PortalCard({super.key, required this.portal, this.flavorTheme});

  @override
  Component build(BuildContext context) {
    Component card;
    final url = portal.url;

    if (kIsWeb) {
      card = a(
        href: url ?? "",
        styles: Styles(pointerEvents: url == null ? .none : null, color: .unset, textDecoration: .none),
        [
          div(
            classes: "portal-card zoomable",
            styles: Styles(
              border: Border.all(color: flavorTheme?.light.sky, width: 2.px),
              backgroundColor: flavorTheme?.light.mantle,
            ),
            [
              img(src: portal.image, height: 120),
              p(styles: Styles(margin: .zero, fontSize: 1.5.em), [.text(portal.name)]),
            ],
          ),
        ],
      );
    } else {
      card = div(
        classes: "portal-card zoomable",
        styles: Styles(
          border: Border.all(color: flavorTheme?.light.sky, width: 2.px),
          backgroundColor: flavorTheme?.light.mantle,
        ),
        [CircularProgressIndicator()],
      );
    }

    return CatppuccinFlavor(theme: flavorTheme, child: card);
  }
}
