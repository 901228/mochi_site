import "package:jaspr/dom.dart";
import "package:jaspr/server.dart";
import "package:jaspr_content/jaspr_content.dart";

import "../../components/ui/anchor_link.dart";
import "../../components/ui/bulma/icon.dart";

/// A code block component that renders syntax-highlighted code.
class HeadingLink extends CustomComponent {
  const HeadingLink() : super.base();

  static Component from({
    required String tag,
    required String title,
    String? id,
    Map<String, String>? extraAttributes,
    Key? key,
  }) => HeadingWithLink(key: key, tag: tag, title: title, id: id, extraAttributes: extraAttributes);

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node case ElementNode(
      tag: "h1" || "h2" || "h3" || "h4" || "h5" || "h6",
      :final children,
      :final attributes,
    )) {
      if (children == null) return null;
      final source = children.map((c) => c.innerText).join(" ");

      return from(tag: node.tag, title: source, id: attributes["id"], extraAttributes: attributes);
    }

    return null;
  }
}

class HeadingWithLink extends StatelessComponent {
  const HeadingWithLink({
    super.key,
    required this.tag,
    required this.title,
    required this.id,
    this.extraAttributes,
  });

  final String? id;
  final String tag;
  final String title;
  final Map<String, String>? extraAttributes;

  @override
  Component build(BuildContext context) {
    final Component? linkButton = id != null
        ? AnchorLink(
            classes: "heading-link-button ml-1",
            anchor: id!,
            child: Icon.lucide(icon: "hash"),
          )
        : null;

    if (tag == "h1") {
      return h1(classes: "title is-1 heading-link", attributes: extraAttributes, [.text(title), ?linkButton]);
    } else if (tag == "h2") {
      return h2(classes: "title is-2 heading-link", attributes: extraAttributes, [.text(title), ?linkButton]);
    } else if (tag == "h3") {
      return h3(classes: "title is-3 heading-link", attributes: extraAttributes, [.text(title), ?linkButton]);
    } else if (tag == "h4") {
      return h4(classes: "title is-4 heading-link", attributes: extraAttributes, [.text(title), ?linkButton]);
    } else if (tag == "h5") {
      return h5(classes: "title is-5 heading-link", attributes: extraAttributes, [.text(title), ?linkButton]);
    } else if (tag == "h6") {
      return h6(classes: "title is-6 heading-link", attributes: extraAttributes, [.text(title), ?linkButton]);
    }

    return .fragment([]);
  }

  @css
  static List<StyleRule> get styles => [
    css(".heading-link", [
      css(".heading-link-button").styles(opacity: 0.1),
      css("&:hover .heading-link-button").styles(opacity: 1.0),
    ]),
  ];
}
