import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";

import "modifier.dart" show getModifier;

/// Bulma Navbar Component
/// Supports a limited subset of the available options
/// See https://bulma.io/documentation/components/navbar/ for a detailed description
class NavBar extends StatelessComponent {
  const NavBar({this.brand, this.menu, super.key});

  final NavbarBrand? brand;
  final NavbarMenu? menu;

  @override
  Component build(BuildContext context) {
    return nav(classes: "navbar block", [if (brand != null) brand!, if (menu != null) menu!]);
  }
}

class NavbarBrand extends StatelessComponent {
  const NavbarBrand({required this.children, super.key});

  final List<Component> children;

  @override
  Component build(BuildContext context) {
    return div(classes: "navbar-brand", children);
  }
}

class NavbarBurger extends StatelessComponent {
  const NavbarBurger({required this.isActive, required this.onToggle});

  final bool isActive;
  final void Function() onToggle;

  @override
  Component build(BuildContext context) {
    return button(
      classes:
          "navbar-burger"
          "${getModifier(isActive, "is-active")}",
      attributes: {"role": "button", "data-target": "navMenu"},
      onClick: () {
        onToggle();
      },
      [
        span(attributes: {"aria-hidden": "true"}, []),
        span(attributes: {"aria-hidden": "true"}, []),
        span(attributes: {"aria-hidden": "true"}, []),
        span(attributes: {"aria-hidden": "true"}, []),
      ],
    );
  }
}

class NavbarMenu extends StatelessComponent {
  const NavbarMenu({this.isActive = false, required this.items, this.endItems = const [], super.key});

  final bool isActive;
  final List<Component> items;
  final List<Component> endItems;

  @override
  Component build(BuildContext context) {
    return div(
      classes:
          "navbar-menu"
          "${getModifier(isActive, "is-active")}",
      [div(classes: "navbar-start", items), div(classes: "navbar-end", endItems)],
    );
  }
}

class NavbarItem extends StatelessComponent {
  const NavbarItem({super.key, required this.child, this.href, this.isSelected = false})
    : items = null,
      isRootDiv = false;
  const NavbarItem.div({super.key, required this.child, this.href, this.isSelected = false})
    : items = null,
      isRootDiv = true;
  const NavbarItem.dropdown({super.key, required this.child, required this.items})
    : href = null,
      isSelected = false,
      isRootDiv = true;

  final Component child;
  final String? href;
  final List<Component>? items;
  final bool isSelected;
  final bool isRootDiv;

  @override
  Component build(BuildContext context) {
    if (items == null) {
      if (isRootDiv) {
        return div(
          classes:
              "navbar-item"
              "${getModifier(isSelected, "is-selected")}",
          [child],
        );
      } else {
        return a(
          href: href ?? "#",
          classes:
              "navbar-item"
              "${getModifier(isSelected, "is-selected")}",
          [child],
        );
      }
    } else {
      return div(classes: "navbar-item has-dropdown is-hoverable", [
        div(classes: "navbar-link", [child]),
        div(classes: "navbar-dropdown is-boxed", items!),
      ]);
    }
  }
}

class NavbarDivider extends StatelessComponent {
  const NavbarDivider({super.key});

  @override
  Component build(BuildContext context) {
    return hr(classes: "navbar-divider");
  }
}
