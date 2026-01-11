import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";
import "package:universal_web/web.dart" as web;

import "../components/ui/bulma/modifier.dart" show isWebSkeleton;

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

@client
class PortalCard extends StatelessComponent {
  final PortalItem item;
  const PortalCard({super.key, required this.item});

  @override
  Component build(BuildContext context) {
    final url = item.url;
    final cardContent = div(classes: "card $isWebSkeleton", [
      div(classes: "card-image", [
        figure(classes: "image is-square", [
          img(
            src: item.image,
            styles: Styles(padding: .all(2.rem)),
            alt: "${item.name} logo",
          ),
        ]),
      ]),
      div(classes: "card-content", [
        div(classes: "content has-text-centered", [.text(item.name)]),
      ]),
    ]);

    return div(classes: "cell", [
      if (kIsWeb) a(href: url ?? "#", [cardContent]) else cardContent,
    ]);
  }
}

class PortalPage extends StatelessComponent {
  final List<PortalItem> portals;
  final List<PortalItem> actions;
  const PortalPage({super.key, this.portals = const [], this.actions = const []});

  @override
  Component build(BuildContext context) {
    return section(classes: "section", [
      div(classes: "container", [
        div(classes: "grid is-col-min-8", portals.map((item) => PortalCard(item: item)).toList()),
      ]),
    ]);
  }
}
