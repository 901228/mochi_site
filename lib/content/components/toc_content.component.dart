import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";
import "package:jaspr_content/jaspr_content.dart";

import "../../components/ui/bulma.dart";
import "../content.dart";

class TocContent extends CustomComponent {
  const TocContent() : super.base();

  static Component from({Key? key}) => TocContentComponent(key: key);

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node case ElementNode(tag: "TocContent")) {
      return from();
    }

    return null;
  }
}

class TocContentComponent extends StatelessComponent {
  const TocContentComponent({super.key});

  @override
  Component build(BuildContext context) {
    return Grid(
      children:
          RouterTree.currentItem(context)?.routes
              .map(
                (item) => a(href: item.path, [
                  Card(cardContent: div(classes: "content has-text-centered", [.text(item.name)])),
                ]),
              )
              .toList() ??
          [],
    );
  }

  @css
  static List<StyleRule> get styles => [];
}
