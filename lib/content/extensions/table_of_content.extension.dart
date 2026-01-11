import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";
import "package:jaspr_content/jaspr_content.dart" hide TocEntry, TableOfContents, TableOfContentsExtension;
import "package:jaspr_router/jaspr_router.dart";

import "../../config.dart";

class MochiTableOfContentsExtension implements PageExtension {
  const MochiTableOfContentsExtension({this.maxHeaderDepth = 3, this.hideH1 = true});

  final int maxHeaderDepth;
  final bool hideH1;

  static final _headerRegex = RegExp(r"^h(\d)$", caseSensitive: false);

  @override
  Future<List<Node>> apply(Page page, List<Node> nodes) async {
    final toc = <MochiTocEntry>[];
    final stack = <MochiTocEntry>[];

    final toVisit = [...nodes.reversed];

    while (toVisit.isNotEmpty) {
      final node = toVisit.removeLast();
      if (node is! ElementNode) continue;

      final depth = _headerRegex.firstMatch(node.tag)?.group(1);
      if (depth == null) {
        // Not a header, continue searching children.
        toVisit.addAll(node.children?.reversed ?? []);
        continue;
      }

      // if [hideH1] is true, let Level 0 = h2, Level 1 = h3, etc.
      // else, let Level 0 = h1, Level 1 = h2, etc.
      final level = int.parse(depth) - (hideH1 ? 2 : 1);
      if (level < 0 || level > maxHeaderDepth - 2) continue;

      final id = node.attributes["id"];
      // Header can't be linked to without an id.
      if (id == null) continue;

      // Don't include if no_toc is specified as a class on the header.
      if (node.attributes["class"]?.contains("no_toc") ?? false) continue;

      final text = node.innerText;
      final entry = MochiTocEntry(text, id, []);

      while (level < stack.length) {
        stack.removeLast();
      }

      if (level > stack.length) {
        // Found h(x+1) without previous h(x) header.
        continue;
      }

      if (stack.isEmpty) {
        toc.add(entry);
        stack.add(entry);
      } else {
        stack.last.children.add(entry);
      }
    }

    page.apply(data: {"toc": MochiTableOfContents(toc)});

    return nodes;
  }
}

class MochiTableOfContents {
  const MochiTableOfContents(this.entries);

  final List<MochiTocEntry> entries;

  Component build() {
    return ul([..._buildToc(entries)]);
  }

  Iterable<Component> _buildToc(List<MochiTocEntry> toc, [int indent = 0]) sync* {
    for (final entry in toc) {
      yield li(styles: Styles(padding: Padding.only(left: (0.75 * indent).em)), [
        Builder(
          builder: (context) {
            final route = RouteState.of(context);
            if (route.path != null) {
              return a(href: "${AppConfig.relativeRoute(route.path!)}#${entry.id}", [.text(entry.text)]);
            } else {
              return .text(entry.text);
            }
          },
        ),
      ]);
      if (entry.children.isNotEmpty) {
        yield* _buildToc(entry.children, indent + 1);
      }
    }
  }
}

class MochiTocEntry {
  MochiTocEntry(this.text, this.id, this.children);

  final String text;
  final String id;
  final List<MochiTocEntry> children;
}
