import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";

import "theme.dart";

List<StyleRule> get lucideTheme => [
  css(".lucide-icon", [
    css("&.is-small", [
      css("&").styles(
        width: .expression("var(--bulma-icon-dimensions-small) !important"),
        height: .expression("var(--bulma-icon-dimensions-small) !important"),
      ),
      css("svg").styles(width: 0.75.rem, height: 0.75.rem),
    ]),

    css("&", [
      css("&").styles(
        width: .expression("var(--bulma-icon-dimensions)"),
        height: .expression("var(--bulma-icon-dimensions)"),
      ),
      css("svg").styles(width: 1.rem, height: 1.rem),
    ]),
    css("&.is-normal", [
      css("&").styles(
        width: .expression("var(--bulma-icon-dimensions) !important"),
        height: .expression("var(--bulma-icon-dimensions) !important"),
      ),
      css("svg").styles(width: 1.rem, height: 1.rem),
    ]),

    for (final size in ["medium", "large"])
      css("&.is-$size", [
        css("&").styles(
          width: .expression("var(--bulma-icon-dimensions-$size) !important"),
          height: .expression("var(--bulma-icon-dimensions-$size) !important"),
        ),
        css("svg").styles(
          width: .expression("var(--bulma-icon-dimensions-$size)"),
          height: .expression("var(--bulma-icon-dimensions-$size)"),
        ),
      ]),
  ]),

  for (final size in [1, 2, 3, 4, 5, 6]) ...[
    CustomStyleRule(".title.is-$size .lucide-icon { vertical-align: bottom; }"),
    css(".title.is-$size", [
      css(".lucide-icon", [
        css("&").styles(
          width: .expression("var(--bulma-size-$size)"),
          height: .expression("var(--bulma-size-$size)"),
        ),
        css("svg").styles(
          width: .expression("var(--bulma-size-$size)"),
          height: .expression("var(--bulma-size-$size)"),
        ),
      ]),
    ]),
  ],
];

List<Component> get lucideInitialization => [
  script(src: "https://unpkg.com/lucide@latest"),
  script(
    content: """
      function initLucide() {
        if (window.lucide) {
          lucide.createIcons();
        }
      }

      // first time initialization
      initLucide();

      // Only initialize on re-renders by Jaspr
      let rafId;
      const observer = new MutationObserver((mutations) => {
        // check if there are new `data-lucide` attributes
        const hasNewIcons = mutations.some(mutation =>
          Array.from(mutation.addedNodes).some(node =>
            node.nodeType === 1 &&
            node.hasAttribute?.('data-lucide') &&
            !node.classList?.contains('lucide')
          )
        );

        if (hasNewIcons) {
          // use requestAnimationFrame to ensure DOM is updated
          cancelAnimationFrame(rafId);
          rafId = requestAnimationFrame(() => {
            initLucide();
          });
        }
      });

      observer.observe(document.body, {
        childList: true,
        subtree: true,
        attributes: false  // DO NOT listen to attribute changes, to avoid infinite loops
      });
    """,
  ),
];
