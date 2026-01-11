import "dart:async";

import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";
import "package:universal_web/web.dart" as web;

import "bulma/icon.dart";
import "bulma/modifier.dart" show isWebSkeleton;

@client
class CopyButton extends StatefulComponent {
  final String selectors;
  const CopyButton({super.key, required this.selectors});

  @override
  State<CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<CopyButton> {
  bool copied = false;

  @override
  Component build(BuildContext context) {
    return button(
      classes: "copy-button $isWebSkeleton",
      events: {
        "click": (event) {
          final target = event.currentTarget as web.Element;
          final content = target.parentElement?.querySelector(component.selectors)?.textContent;
          if (content == null) {
            return;
          }
          web.window.navigator.clipboard.writeText(content);
          setState(() {
            copied = true;
          });
          Timer(const Duration(seconds: 2), () {
            setState(() {
              copied = false;
            });
          });
        },
      },
      styles: Styles(opacity: copied ? 0.75 : null),
      [
        Icon.lucide(
          icon: "check",
          styles: Styles(display: copied ? null : .none),
        ),
        Icon.lucide(
          icon: "copy",
          styles: Styles(display: copied ? .none : null),
        ),
      ],
    );
  }
}
