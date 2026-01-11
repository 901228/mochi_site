import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";
import "package:jaspr_content/jaspr_content.dart";

abstract class MochiLayoutBase implements PageLayout {
  const MochiLayoutBase();

  Component buildBody(Page page, Component child);

  @override
  Component buildLayout(Page page, Component child) =>
      MochiLayoutBaseComponent(child: buildBody(page, child));
}

class MochiLayoutBaseComponent extends StatelessComponent {
  final Component child;
  const MochiLayoutBaseComponent({super.key, required this.child});

  @override
  Component build(BuildContext context) => div(classes: "jaspr-content", [child]);

  @css
  static List<StyleRule> get styles => [
    css(".jaspr-content").styles(
      padding: Padding.only(top: 2.rem, left: 1.5.rem, right: 1.5.rem, bottom: 4.rem),
      margin: Margin.symmetric(horizontal: Unit.auto),
      fontFamily: .list([FontFamily("Iansui"), FontFamily("Comfortaa"), FontFamilies.sansSerif]),
    ),
  ];
}
