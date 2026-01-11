import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";
import "package:jaspr_content/jaspr_content.dart";

import "layout.dart";

class MochiTocLayout extends MochiLayoutBase {
  const MochiTocLayout();

  @override
  String get name => "toc";

  @override
  Component buildBody(Page page, Component child) => MochiTocLayoutComponent(data: page.data, child: child);
}

class MochiTocLayoutComponent extends StatelessComponent {
  final PageDataMap data;
  final Component child;
  const MochiTocLayoutComponent({required this.data, required this.child});

  @override
  Component build(BuildContext context) {
    return child;
  }

  @css
  static List<StyleRule> get styles => [];
}
