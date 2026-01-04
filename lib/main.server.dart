library;

import "package:jaspr/dom.dart";
import "package:jaspr/server.dart";

import "app.dart";
import "main.server.options.dart";

void main() {
  Jaspr.initializeApp(options: defaultServerOptions);

  runApp(
    Document(
      title: "Mochi Site",
      styles: [
        css.import("https://fonts.googleapis.com/css?family=Comfortaa"),
        css.import("https://cdn.jsdelivr.net/npm/bulma@1.0.4/css/bulma.min.css"),
        css.import("https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"),
        css("html, body").styles(
          width: 100.percent,
          height: 100.percent,
          padding: .zero,
          margin: .zero,
          fontFamily: const .list([FontFamily("Comfortaa"), FontFamilies.sansSerif]),
        ),

        // to make footer sticky at the bottom
        css("body, #root").styles(display: .flex, height: 100.vh, flexDirection: .column),
        css(".main").styles(flex: .grow(1)),
      ],
      head: [
        link(rel: "manifest", href: "manifest.json"),
        script(src: "flutter_bootstrap.js", async: true),
      ],
      viewport: "width=device-width, initial-scale=1.0",
      body: .fragment([
        div(id: "root", attributes: {"data-theme": "light"}, [App()]),
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
      ]),
    ),
  );
}
