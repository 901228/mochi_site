import "package:jaspr/dom.dart";
import "package:jaspr/server.dart";
import "package:jaspr_content/jaspr_content.dart";

import "../../components/ui/anchor_link.dart";
import "../../components/ui/bulma/icon.dart";

/// A code block component that renders syntax-highlighted code.
class HeadingLink extends CustomComponent {
  const HeadingLink() : super.base();

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node case ElementNode(
      tag: "h1" || "h2" || "h3" || "h4" || "h5" || "h6",
      :final children,
      :final attributes,
    )) {
      if (children == null) return null;
      final source = children.map((c) => c.innerText).join(" ");

      final Component? linkButton = attributes["id"] != null
          ? AnchorLink(
              classes: "heading-link-button ml-1",
              anchor: attributes["id"]!,
              child: Icon.lucide(icon: "hash"),
            )
          : null;

      if (node case ElementNode(tag: "h1")) {
        return h1(classes: "title is-1 heading-link", attributes: attributes, [.text(source), ?linkButton]);
      } else if (node case ElementNode(tag: "h2")) {
        return h2(classes: "title is-2 heading-link", attributes: attributes, [.text(source), ?linkButton]);
      } else if (node case ElementNode(tag: "h3")) {
        return h3(classes: "title is-3 heading-link", attributes: attributes, [.text(source), ?linkButton]);
      } else if (node case ElementNode(tag: "h4")) {
        return h4(classes: "title is-4 heading-link", attributes: attributes, [.text(source), ?linkButton]);
      } else if (node case ElementNode(tag: "h5")) {
        return h5(classes: "title is-5 heading-link", attributes: attributes, [.text(source), ?linkButton]);
      } else if (node case ElementNode(tag: "h6")) {
        return h6(classes: "title is-6 heading-link", attributes: attributes, [.text(source), ?linkButton]);
      }
    }

    return null;
  }

  @css
  static List<StyleRule> get styles => [
    css(".heading-link", [
      css(".heading-link-button").styles(opacity: 0.1),
      css("&:hover .heading-link-button").styles(opacity: 1.0),
    ]),
  ];
}
