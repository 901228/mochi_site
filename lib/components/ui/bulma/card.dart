import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";

import "image.dart";

class Card extends StatelessComponent {
  const Card({
    super.key,
    this.classes,
    this.cardHeaderTitle,
    this.cardHeaderIcon,
    this.cardHeaderIconCallback,
    this.cardContent,
    this.cardImage,
    this.cardFooterItems = const [],
  });

  final String? classes;
  final Component? cardHeaderTitle;
  final Component? cardHeaderIcon;
  final void Function()? cardHeaderIconCallback;
  final Component? cardContent;
  final Image? cardImage;
  final List<CardFooterItem> cardFooterItems;

  @override
  Component build(BuildContext context) {
    return div(classes: "card $classes", [
      if (cardHeaderTitle != null || cardHeaderIcon != null)
        header(classes: "card-header", [
          if (cardHeaderTitle != null) p(classes: "card-header-title", [cardHeaderTitle!]),
          if (cardHeaderIcon != null)
            button(classes: "card-header-icon", onClick: cardHeaderIconCallback, [cardHeaderIcon!]),
        ]),

      if (cardImage != null) div(classes: "card-image", [cardImage!]),

      if (cardContent != null) div(classes: "card-content", [cardContent!]),

      if (cardFooterItems.isNotEmpty) footer(classes: "card-footer", cardFooterItems),
    ]);
  }
}

class CardFooterItem extends StatelessComponent {
  CardFooterItem.a({super.key, required this.item, required String href})
    : tag = "a",
      attributes = {"href": href};

  final Component item;
  final String tag;
  final Map<String, String> attributes;

  @override
  Component build(BuildContext context) {
    return .element(tag: tag, classes: "card-footer-item", attributes: attributes, children: [item]);
  }
}
