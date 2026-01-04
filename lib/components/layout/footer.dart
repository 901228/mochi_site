import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";

import "../ui/bulma/button.dart";
import "../ui/bulma/icon.dart";

class Footer extends StatelessComponent {
  const Footer({super.key});

  @override
  Component build(BuildContext context) {
    return footer(classes: "footer", [
      div(classes: "container", [
        nav(classes: "level", [
          div(classes: "level-item has-text-centered", [
            div(styles: Styles(display: .flex, flexDirection: .column), [
              a(href: "https://jaspr.site", target: .blank, [JasprBadge.lightTwoTone()]),
              a(href: "https://bulma.io", target: .blank, [
                img(
                  src: "https://bulma.io/assets/images/made-with-bulma.png",
                  alt: "Made with Bulma",
                  width: 128,
                  height: 24,
                ),
              ]),
            ]),
          ]),
          div(classes: "level-item has-text-centered", [
            div([
              p([
                .text("Build by "),
                a(href: "https://github.com/901228", [
                  IconLabel(
                    icon: .lucide(icon: "github"),
                    label: "Mochi",
                  ),
                ]),
              ]),
              div([
                Button.a(
                  child: IconLabel(
                    icon: .lucide(icon: "twitter"),
                    label: "Follow @harry900000",
                  ),
                  href: "https://twitter.com/harry900000",
                  size: .small,
                  styles: Styles(color: Colors.white, backgroundColor: .hsl(206, 82, 63)),
                ),
              ]),
            ]),
          ]),
        ]),
        div(classes: "content has-text-centered", [
          p([
            // TODO: check license
            .text("The source code is licensed "),
            a(href: "https://opensource.org/license/mit", [.text("MIT")]),
            .text(". The website content is licensed "),
            a(href: "https://creativecommons.org/licenses/by-nc-sa/4.0/", [.text("CC BY NC SA 4.0")]),
            .text("."),
          ]),
        ]),
      ]),
    ]);
  }
}
