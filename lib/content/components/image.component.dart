import "package:jaspr/jaspr.dart";
import "package:jaspr_content/jaspr_content.dart";

import "../../components/ui/bulma.dart" as bulma;

/// An image component with optional zooming and caption support.
class Image extends CustomComponent {
  const Image() : super.base();

  static Component from({required String src, String? alt, bool showCaption = true, Key? key}) =>
      bulma.Image.zoomable(key: key, src: src, alt: alt, showCaption: showCaption);

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node case ElementNode(tag: "img" || "Image", :final attributes)) {
      assert(attributes.containsKey("src"), 'Image must have a "src" argument. Found $attributes');

      return from(src: attributes["src"]!, alt: attributes["alt"]);
    }
    return null;
  }
}
