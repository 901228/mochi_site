import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";
import "package:jaspr_content/jaspr_content.dart";

import "../../components/ui/bulma/icon.dart";

enum CalloutType {
  note("success", "info"),
  info("info", "lightbulb"),
  important("primary", "message-square-warning"),
  warning("warning", "triangle-alert"),
  caution("danger", "octagon-alert");

  const CalloutType(this.color, this.icon);
  final String color;
  final String icon;
}

/// A custom callout component.
///
/// Can be one of 'NOTE', 'INFO', 'IMPORTANT', 'WARNING', or 'CAUTION'.
class Callout extends CustomComponent {
  const Callout() : super.base();

  static const Map<String, String> calloutsToClass = {
    "NOTE": "success",
    "INFO": "info",
    "IMPORTANT": "primary",
    "WARNING": "warning",
    "CAUTION": "danger",
  };

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node case ElementNode(
      tag: "blockquote",
      children: [ElementNode(tag: "p", children: [TextNode(:final text)])],
    )) {
      for (final callout in CalloutType.values) {
        if (text.trim().startsWith("[[!${callout.name.toUpperCase()}]]")) {
          final content = text.replaceAll("[[!${callout.name.toUpperCase()}]]", "");
          return blockquote(
            classes: "has-text-${callout.color}",
            styles: Styles(
              border: .only(
                left: BorderSide(
                  color: Color(
                    "hsl(var(--bulma-${callout.color}-h),var(--bulma-${callout.color}-s),var(--bulma-${callout.color}-l))!important",
                  ),
                ),
              ),
              // backgroundColor: Color(
              //   "hsla(var(--bulma-${callout.color}-h),var(--bulma-${callout.color}-s),var(--bulma-${callout.color}-l), 8%)",
              // ),
            ),
            [
              IconLabel.iconText(
                icon: .lucide(icon: callout.icon),
                label: callout.name,
              ),
              p(classes: "pl-1", [.text(content)]),
            ],
          );
        }
      }
    }

    return null;
  }
}
