library;

import "package:jaspr/jaspr.dart";
import "package:jaspr_router/jaspr_router.dart";

// components
export "components/callout.component.dart" show Callout, CalloutType;
export "components/codeblock.component.dart" show CodeBlock;
export "components/file_tree.component.dart" show FileTree;
export "components/heading_link.component.dart" show HeadingLink;
export "components/image.component.dart" show Image;
export "components/toc_content.component.dart" show TocContent;
// extensions
export "extensions/table_of_content.extension.dart";
// layouts
export "layouts/blog.layout.dart";
export "layouts/docs.layout.dart";
export "layouts/toc.layout.dart";
// loaders
export "loaders/filesystem.loader.dart";

class RouterTree extends InheritedComponent {
  RouterTree({super.key, required super.child, required List<RouteBase> routes}) {
    parse(routes);
  }

  final Set<RouteTreeItem> routes = {};

  void parse(List<RouteBase> routes) {
    for (final route in routes) {
      if (route is! Route) continue;

      String path = route.path;
      if (path.startsWith("/")) path = path.substring(1);
      final pathList = path.split("/");

      final name = pathList.removeLast();
      if (pathList.isEmpty) {
        // is root path
        this.routes.add(RouteTreeItem(name: name, path: path));
      } else {
        RouteTreeItem? parent = _findItem(pathList.toList());
        if (parent == null) {
          for (final item in pathList) {
            if (parent == null) {
              for (final route in this.routes) {
                if (route.name == item) {
                  parent = route;
                  break;
                }
              }
              if (parent == null) {
                parent = RouteTreeItem(name: item, path: item);
                this.routes.add(parent);
              }
            } else {
              RouteTreeItem? findParent;
              for (final route in parent.routes) {
                if (route.name == item) {
                  findParent = route;
                  break;
                }
              }
              if (findParent == null) {
                parent.routes.add(RouteTreeItem(name: item, path: "${parent.path}/$item"));
                parent = parent.routes.last;
              } else {
                parent = findParent;
              }
            }
          }
        }
        assert(parent != null);
        parent!.routes.add(RouteTreeItem(name: name, path: path));
      }
    }
  }

  RouteTreeItem? findItem(String path) {
    if (path.startsWith("/")) path = path.substring(1);
    final pathList = path.split("/");
    return _findItem(pathList);
  }

  RouteTreeItem? _findItem(List<String> pathList, [Set<RouteTreeItem>? routes]) {
    routes ??= this.routes;

    final name = pathList.removeAt(0);
    for (final item in routes) {
      if (item.name == name) {
        if (pathList.isEmpty) {
          return item;
        } else {
          return _findItem(pathList.toList(), item.routes);
        }
      }
    }

    return null;
  }

  static RouterTree of(BuildContext context) => maybeOf(context)!;

  static RouterTree? maybeOf(BuildContext context) =>
      context.dependOnInheritedComponentOfExactType<RouterTree>();

  static RouteTreeItem? currentItem(BuildContext context) {
    final routerTree = maybeOf(context);
    if (routerTree == null) return null;

    final path = RouteState.of(context).path;
    if (path == null) return null;

    return routerTree.findItem(path);
  }

  @override
  bool updateShouldNotify(covariant InheritedComponent oldComponent) => true;
}

class RouteTreeItem {
  RouteTreeItem({required this.name, required this.path});

  final String name;
  final String path;
  final Set<RouteTreeItem> routes = <RouteTreeItem>{};

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {"name": name, "path": path};
    if (routes.isNotEmpty) {
      result["routes"] = routes.map((e) => e.toJson()).toList();
    }
    return result;
  }

  @override
  String toString() => toJson().toString();
  @override
  int get hashCode => path.hashCode;
  @override
  bool operator ==(Object other) => identical(this, other) || (other is RouteTreeItem && path == other.path);
}
