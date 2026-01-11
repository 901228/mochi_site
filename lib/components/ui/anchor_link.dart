import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";
import "package:jaspr_router/jaspr_router.dart";

import "../../config.dart";

class AnchorLink extends StatelessComponent {
  final String anchor;
  final Component child;
  final String? classes;
  const AnchorLink({super.key, required this.anchor, required this.child, this.classes});

  @override
  Component build(BuildContext context) {
    final String? path = RouteState.of(context).path;
    if (path != null) return a(classes: classes, href: "${AppConfig.relativeRoute(path)}#$anchor", [child]);

    return .fragment([]);
  }
}
