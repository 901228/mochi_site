import "package:intl/intl.dart";
import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";
import "package:jaspr_content/jaspr_content.dart" hide TocEntry, TableOfContents, TableOfContentsExtension;

import "../../components/ui/bulma/button.dart";
import "../../components/ui/bulma/icon.dart";
import "../../theme/theme.dart";
import "../extensions/table_of_content.extension.dart";
import "layout.dart";

class MochiBlogLayout extends MochiLayoutBase {
  const MochiBlogLayout();

  @override
  String get name => "blog";

  @override
  Component buildBody(Page page, Component child) => MochiBlogLayoutComponent(data: page.data, child: child);
}

class MochiBlogLayoutComponent extends StatelessComponent {
  final PageDataMap data;
  final Component child;
  const MochiBlogLayoutComponent({required this.data, required this.child});

  @override
  Component build(BuildContext context) {
    return div(classes: "container is-max-desktop", [
      div(classes: "post-header", [
        if (data.page["title"] case final String title)
          h1(classes: "title is-1", id: title.replaceAll(" ", "-"), [.text(title)]),

        div(classes: "metadata is-flex is-flex-direction-column", styles: Styles(gap: .row(0.5.rem)), [
          if (data.page["date"] case final String _)
            div([
              p([
                .text(
                  [
                    if (data.page["date"] case final String date)
                      DateFormat("yyyy年MM月dd日").format(DateFormat("yyyy-MM-dd").parse(date)),
                  ].join(" • "),
                ),
              ]),
            ]),

          if (data.page["tags"] case final List<Object?> tags)
            div([
              p(classes: "is-inline pr-2", [.text("Categories:")]),
              div(classes: "tags is-inline-flex", [
                for (final tag in tags)
                  a(
                    classes: "tag is-info",
                    href: "#", // TODO: add tag link
                    [.text(tag.toString())],
                  ),
              ]),
            ]),

          if (data.page["categories"] case final List<Object?> categories)
            div([
              p(classes: "is-inline pr-2", [.text("Tags:")]),
              div(classes: "tags is-inline-flex", [
                for (final category in categories)
                  a(
                    classes: "tag is-info",
                    href: "#", // TODO: add category link
                    [.text(category.toString())],
                  ),
              ]),
            ]),
        ]),
      ]),
      hr(
        styles: Styles(height: .zero, margin: .all(1.rem), border: .none),
      ),

      div(classes: "is-flex is-flex-direction-row-reverse is-justify-content-space-between", [
        if (data["toc"] case final MochiTableOfContents toc)
          aside(id: "toc-aside", classes: "toc is-hidden-mobile ml-5", [
            nav(
              classes: "is-flex is-flex-direction-column px-4 py-4",
              styles: Styles(
                position: .sticky(top: 4.rem),
                border: .only(
                  left: BorderSide(width: 1.px, style: .dashed, color: BulmaColor.text),
                ),
              ),
              [toc.build()],
            ),
          ]),

        div(styles: Styles(width: 100.percent), [
          if (data["toc"] case final MochiTableOfContents toc)
            details(classes: "card is-hidden-tablet", [
              summary(classes: "card-header-title", styles: Styles(display: .listItem), [
                .text("Table of Contents"),
              ]),

              div(classes: "toc card-content", [
                div(classes: "content", [toc.build()]),
              ]),
            ]),

          child,
        ]),
      ]),

      div(
        classes: "is-flex is-flex-direction-row-reverse is-hidden-tablet",
        styles: Styles(
          position: .sticky(bottom: 2.rem, right: 2.rem),
        ),
        [
          Button(
            id: "to-top-button",
            child: Icon.lucide(icon: "chevron-up", classes: "mx-0", size: .medium),
            style: .rounded,
            classes: "p-2",
            attributes: {"onclick": "window.scrollTo({top: 0, behavior: 'smooth'}); return false;"},
            onPressed: () {},
          ),
        ],
      ),

      script(
        content: """(function () {
          const tocLinks = document.querySelectorAll("#toc-aside a");
          const toTopButton = document.getElementById("to-top-button");

          // clear all active links' styles
          function clearActiveLinks() {
            tocLinks.forEach(link => link.classList.remove("has-text-primary", "is-underlined"));
          }

          // update active link's styles
          function updateActiveLink(id) {
            clearActiveLinks();
            if (id) {
              let leave_headers = false;
              tocLinks.forEach(link => {
                if (link.getAttribute("href").endsWith(id)) {
                  leave_headers = true;
                  link.classList.add("has-text-primary", "is-underlined");
                }
              });

              if (leave_headers) {
                toTopButton.style.display = null;
              }
              else {
                toTopButton.style.display = "none";
              }
            }
          }

          // get all headings' positions
          function getHeadingPositions() {
            const headings = Array.from(document.querySelectorAll("h1[id], h2[id], h3[id], h4[id], h5[id], h6[id]"));

            return headings.map((heading, index) => {
              const rect = heading.getBoundingClientRect();
              const scrollTop = window.scrollY || document.documentElement.scrollTop;
              const top = scrollTop + rect.top;

              // calculate the range of this section
              // from the current heading to the previous heading (or the bottom of the page)
              const nextHeading = headings[index + 1];
              const bottom = nextHeading
                ? scrollTop + nextHeading.getBoundingClientRect().top
                : document.documentElement.scrollHeight;

              return {
                id: heading.id,
                top: top,
                bottom: bottom,
                element: heading
              };
            });
          }

          // find the section that the current scroll position is in
          function getCurrentSection() {
            const scrollTop = window.scrollY || document.documentElement.scrollTop;
            const viewportTop = scrollTop + 100; // from the top of the viewport down 100px as the threshold

            const sections = getHeadingPositions();

            // check if the viewport is in this section
            for (let i = sections.length - 1; i >= 0; i--) {
              const section = sections[i];
              if (viewportTop >= section.top) {
                return section.id;
              }
            }

            return null;
          }

          // update the active state
          function updateActiveState() {
            const currentSectionId = getCurrentSection();

            if (currentSectionId) {
              updateActiveLink(currentSectionId);
            } else {
              clearActiveLinks();
            }
          }

          // use requestAnimationFrame to optimize performance
          let ticking = false;
          function requestUpdate() {
            if (!ticking) {
              window.requestAnimationFrame(() => {
                updateActiveState();
                ticking = false;
              });
              ticking = true;
            }
          }

          // monitor scroll events
          window.addEventListener("scroll", requestUpdate, { passive: true });

          // monitor resize events (heading positions may change due to window size changes)
          window.addEventListener("resize", requestUpdate, { passive: true });

          // monitor hash changes
          window.addEventListener("hashchange", () => {
            setTimeout(updateActiveState, 100);
          });

          // initialization
          if (document.readyState === "loading") {
            document.addEventListener("DOMContentLoaded", updateActiveState);
          } else {
            updateActiveState();
          }

          // check again after the page is fully loaded
          window.addEventListener("load", () => {
            setTimeout(updateActiveState, 100);
          });
        })();
      """,
      ),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css("hr").styles(
      border: Border.all(style: .inset, width: 1.px, color: BulmaColor.text),
    ),

    css(".toc", [
      css("&").styles(minWidth: 16.rem),
      css("a", [
        css("&").styles(color: BulmaColor.text),
        css("&:hover", [css("&").styles(color: BulmaColor.linkText)]),
      ]),
      css("ul").styles(
        margin: .only(left: .zero),
        listStyle: .none,
      ),
    ]),

    css("details .toc", [
      css("a", [css("&").styles(width: .unset, overflow: .auto, textOverflow: .unset, whiteSpace: .unset)]),
    ]),
  ];
}
