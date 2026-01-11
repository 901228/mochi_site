import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";
import "package:jaspr_content/jaspr_content.dart";
import "package:uuid/uuid.dart";

/// An image component with optional zooming and caption support.
class Image extends CustomComponent {
  const Image() : super.base();

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node case ElementNode(tag: "img" || "Image", :final attributes)) {
      assert(attributes.containsKey("src"), 'Image must have a "src" argument. Found $attributes');

      final String src = attributes["src"]!;
      final String? alt = attributes["alt"];
      final String? caption = attributes["caption"];
      final String imageModalUuid = Uuid().v4();

      return .fragment([
        figure(classes: "image", [
          button(
            classes: "js-modal-trigger",
            attributes: {"data-target": imageModalUuid},
            [img(src: src, alt: alt ?? caption)],
          ),
          if (caption != null) figcaption([.text(caption)]),
        ]),

        div(classes: "modal", id: imageModalUuid, [
          div(classes: "modal-background", []),
          div(classes: "modal-content", [
            p(classes: "image", [img(src: src, alt: alt ?? caption)]),
          ]),
          button(classes: "modal-close is-large", attributes: {"aria-label": "close"}, []),
        ]),
      ]);
    }
    return null;
  }

  @css
  static List<StyleRule> get styles => [
    css("figure.image").styles(display: .flex, flexDirection: .column, alignItems: .center),
  ];
}
