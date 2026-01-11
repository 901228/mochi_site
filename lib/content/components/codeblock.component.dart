import "package:jaspr/dom.dart";
import "package:jaspr/server.dart";
import "package:jaspr_content/jaspr_content.dart";

import "../../components/ui/copy_button.dart";
import "../../theme/theme.dart";

/// A code block component that renders syntax-highlighted code.
class CodeBlock extends CustomComponent {
  const CodeBlock() : super.base();

  static Component from({required String? source, bool isInline = false, String? language, Key? key}) {
    if (!isInline) {
      return BlockCode(key: key, source: source, language: language);
    } else {
      return InlineCode(key: key, source: source, language: language);
    }
  }

  String? getLanguage(Map<String, String> attributes) {
    String? language = attributes["language"];
    if (language == null && (attributes["class"]?.startsWith("language-") ?? false)) {
      language = attributes["class"]!.substring("language-".length);
    }
    return language;
  }

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node
        case ElementNode(tag: "Code" || "CodeBlock", :final children, :final attributes) ||
            ElementNode(
              tag: "pre",
              children: [ElementNode(tag: "code", :final children, :final attributes)],
            )) {
      final language = getLanguage(attributes);
      final source = children?.map((c) => c.innerText).join(" ");

      return from(source: source, isInline: false, language: language);
    } else if (node case ElementNode(tag: "code", :final children, :final attributes)) {
      final language = getLanguage(attributes);
      final source = children?.map((c) => c.innerText).join(" ");

      return from(source: source, isInline: true, language: language);
    }

    return null;
  }
}

class BlockCode extends StatelessComponent {
  const BlockCode({super.key, required this.source, String? language}) : language = language ?? "plaintext";

  final String language;
  final String? source;

  @override
  Component build(BuildContext context) {
    return div(classes: "code-block card", [
      CopyButton(selectors: "pre code"),
      pre(classes: "card-content", styles: Styles(margin: .zero), [
        code(
          classes: "language-$language",
          styles: Styles(padding: .zero, backgroundColor: Colors.transparent),
          [if (source != null) .text(source!)],
        ),
      ]),
      script(attributes: {"type": "text/javascript"}, content: "hljs.highlightAll();"),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css(".code-block", [
      css("&").styles(
        position: Position.relative(),
        width: 100.percent,
        backgroundColor: BulmaColor.blockquoteBackground,
      ),
      css(".copy-button").styles(
        position: Position.absolute(top: 1.rem, right: 1.rem),
        zIndex: ZIndex(10),
        width: 1.25.rem,
        height: 1.25.rem,
        opacity: 0,
      ),
      css("&:hover .copy-button").styles(opacity: 0.75),
    ]),

    css("code").styles(
      fontFamily: .list([
        FontFamily("Fira Code"),
        FontFamily("FakePearl"),
        FontFamily("Sans Mono"),
        FontFamily("Consolas"),
        FontFamilies.courierNew,
        FontFamilies.courier,
        FontFamilies.monospace,
      ]),
    ),
  ];
}

class InlineCode extends StatelessComponent {
  const InlineCode({super.key, required this.source, String? language}) : language = language ?? "plaintext";

  final String language;
  final String? source;

  @override
  Component build(BuildContext context) {
    return .fragment([
      code(classes: "inline-code language-$language", [if (source != null) .text(source!)]),
      script(attributes: {"type": "text/javascript"}, content: "hljs.highlightAll();"),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css("code").styles(
      fontFamily: .list([
        FontFamily("Fira Code"),
        FontFamily("FakePearl"),
        FontFamily("Sans Mono"),
        FontFamily("Consolas"),
        FontFamilies.courierNew,
        FontFamilies.courier,
        FontFamilies.monospace,
      ]),
    ),

    css("code.inline-code").styles(
      position: .relative(),
      maxWidth: 100.percent,
      padding: .symmetric(vertical: 0.25.em, horizontal: 0.75.em),
      radius: BorderRadius.circular(0.75.rem),
      backgroundColor: BulmaColor.blockquoteBackground,
    ),
  ];
}
