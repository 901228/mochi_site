import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";

import "../../config.dart";
import "../ui/bulma/icon.dart";
import "../ui/bulma/navbar.dart";
import "../ui/logo.dart";
import "../ui/theme_toggle_button.dart";

@client
class Header extends StatefulComponent {
  const Header({super.key});

  @override
  State createState() => HeaderState();
}

class HeaderState extends State<Header> {
  bool isActive = false;

  @override
  Component build(BuildContext context) {
    return header([
      NavBar(
        brand: NavbarBrand(
          children: [
            NavbarItem(child: Logo.withText(), href: AppConfig.relativeRoute("/")),
            NavbarBurger(
              isActive: isActive,
              onToggle: () {
                setState(() => isActive = !isActive);
              },
            ),
          ],
        ),
        menu: NavbarMenu(
          isActive: isActive,
          items: [
            NavbarItem(
              child: IconLabel.iconText(
                icon: .lucide(icon: "house"),
                label: "Home",
              ),
              href: AppConfig.relativeRoute("/"),
            ),
            NavbarItem(
              child: IconLabel.iconText(
                icon: .lucide(icon: "link"),
                label: "Portal",
              ),
              href: AppConfig.relativeRoute("/portal"),
            ),
            NavbarItem(
              child: IconLabel.iconText(
                icon: .lucide(icon: "book-text"),
                label: "Blog",
              ),
              href: AppConfig.relativeRoute("/blog"),
            ),
            // NavbarItem.dropdown(
            //   child: .text("More"),
            //   items: [
            //     NavbarItem(child: .text("About")),
            //     NavbarItem(child: .text("Jobs"), isSelected: true),
            //     NavbarItem(child: .text("Contact")),
            //     NavbarDivider(),
            //     NavbarItem(child: .text("Report an issue")),
            //   ],
            // ),
          ],
          endItems: [
            NavbarItem.div(child: div(classes: "buttons", [ThemeToggleButton()])),
          ],
        ),
      ),
    ]);
  }
}
