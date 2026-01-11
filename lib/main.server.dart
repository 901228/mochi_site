library;

import "package:jaspr/dom.dart";
import "package:jaspr/server.dart";
import "package:jaspr_content/jaspr_content.dart";

import "app.dart";
import "content/content.dart";
import "main.server.options.dart";
import "theme/theme.dart" hide Color;

void main() {
  Jaspr.initializeApp(options: defaultServerOptions);

  runApp(
    ContentApp.custom(
      loaders: [MochiFilesystemLoader("content", prefixPath: "blog")],
      configResolver: PageConfig.all(
        parsers: [MarkdownParser()],
        dataLoaders: [FilesystemDataLoader("content/_data")],
        secondaryOutputs: [],
        templateEngine: LiquidTemplateEngine(),
        enableFrontmatter: true,
        components: [
          CodeBlock(),
          Callout(),
          HeadingLink(),
          Image(),
          FileTree(), // TODO: rewrite
          TocContent(),
        ],
        extensions: [TableOfContentsExtension()],
        layouts: [
          MochiBlogLayout(), DocsLayout(), // TODO: rewrite
          MochiTocLayout(),
        ],
        theme: .none(),
      ),
      routerBuilder: (routes) {
        final contentRoutes = routes.expand((r) => r).toList();

        return Document(
          base: "mochi_site",
          title: "Mochi Site",
          lang: "zh-TW",
          styles: [
            // font
            css.import(
              "https://fonts.googleapis.com/css2?family=Comfortaa:wght@300..700&family=Fira+Code:wght@300..700&family=Iansui&display=swap",
            ),
            for (final weight in ["ExtraLight", "Light", "Regular", "Medium", "SemiBold"])
              css.fontFace(
                family: "FakePearl-$weight",
                url: "https://cdn.jsdelivr.net/gh/max32002/FakePearl@1.1/webfont/FakePearl-$weight.woff",
              ),

            // bulma
            css.import("https://cdn.jsdelivr.net/npm/bulma@1.0.4/css/bulma.min.css"),
            css.import("https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"),

            CustomStyleRule("html { scroll-behavior: smooth; }"),

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

            // light theme
            // catppuccinTheme(catppuccin.latte, .light),
            // css("[data-theme=light] .main").styles(backgroundColor: BulmaColor.background),

            // dark theme
            catppuccinTheme(catppuccin.mocha, .dark),
            css("[data-theme=dark] .main").styles(backgroundColor: BulmaColor.background),

            // lucide icon
            ...lucideTheme,
          ],
          head: [
            link(rel: "manifest", href: "manifest.json"),
            script(src: "flutter_bootstrap.js", async: true),

            script(src: "highlight.min.js"),
            link(
              id: "highlightjs-catppuccin-theme",
              rel: "stylesheet",
              href: "//unpkg.com/@catppuccin/highlightjs@1.0.1/css/catppuccin-latte.css",
            ),

            script(content: "hljs.configure({cssSelector: 'pre code, code.inline-code'});"),
          ],
          viewport: "width=device-width, initial-scale=1.0",
          body: .fragment([
            div(
              id: "root",
              attributes: {"data-theme": "light"},
              [
                RouterTree(
                  routes: contentRoutes,
                  child: App(routes: contentRoutes),
                ),
              ],
            ),
            ...lucideInitialization,

            // initialize data theme
            script(
              content: """
                const current = document.getElementById("root")?.attributes["data-theme"].value;
                if (current != null) {
                  const dataTheme = window.localStorage.getItem("data-theme");
                  if (dataTheme == null) {
                    window.localStorage.setItem("data-theme", current ?? "light");
                  }
                  else {
                    document.getElementById("root")?.setAttribute("data-theme", dataTheme);
                    document.getElementById("highlightjs-catppuccin-theme")?.setAttribute("href", dataTheme == "light" ? "//unpkg.com/@catppuccin/highlightjs@1.0.1/css/catppuccin-latte.css" : "//unpkg.com/@catppuccin/highlightjs@1.0.1/css/catppuccin-mocha.css");
                  }
                }
              """,
            ),

            // bulma modal
            script(
              content: """
                document.addEventListener("DOMContentLoaded", () => {
                  // Functions to open and close a modal
                  function openModal(el) {
                    el.classList.add("is-active");
                  }

                  function closeModal(el) {
                    el.classList.remove("is-active");
                  }

                  function closeAllModals() {
                    (document.querySelectorAll(".modal") || []).forEach((modal) => {
                      closeModal(modal);
                    });
                  }

                  // Add a click event on buttons to open a specific modal
                  (document.querySelectorAll(".js-modal-trigger") || []).forEach((trigger) => {
                    const modal = trigger.dataset.target;
                    const target = document.getElementById(modal);

                    trigger.addEventListener("click", () => {
                      openModal(target);
                    });
                  });

                  // Add a click event on various child elements to close the parent modal
                  (document.querySelectorAll(".modal-background, .modal-close, .modal-card-head .delete, .modal-card-foot .button") || []).forEach((closeButton) => {
                    const target = closeButton.closest(".modal");

                    closeButton.addEventListener("click", () => {
                      closeModal(target);
                    });
                  });

                  // Add a keyboard event to close all modals
                  document.addEventListener("keydown", (event) => {
                    if(event.key === "Escape") {
                      closeAllModals();
                    }
                  });
                });
            """,
            ),
          ]),
        );
      },
    ),
  );
}
