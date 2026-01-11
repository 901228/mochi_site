// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:mochi_site/components/layout/header.dart' as _header;
import 'package:mochi_site/components/ui/copy_button.dart' as _copy_button;
import 'package:mochi_site/components/ui/theme_toggle_button.dart'
    as _theme_toggle_button;
import 'package:mochi_site/content/components/codeblock.component.dart'
    as _codeblock$component;
import 'package:mochi_site/content/components/file_tree.component.dart'
    as _file_tree$component;
import 'package:mochi_site/content/components/heading_link.component.dart'
    as _heading_link$component;
import 'package:mochi_site/content/components/toc_content.component.dart'
    as _toc_content$component;
import 'package:mochi_site/content/layouts/blog.layout.dart' as _blog$layout;
import 'package:mochi_site/content/layouts/layout.dart' as _layout;
import 'package:mochi_site/content/layouts/toc.layout.dart' as _toc$layout;
import 'package:mochi_site/pages/portal.page.dart' as _portal$page;
import 'package:mochi_site/app.dart' as _app;

/// Default [ServerOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.server.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultServerOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ServerOptions get defaultServerOptions => ServerOptions(
  clientId: 'main.client.dart.js',
  clients: {
    _header.Header: ClientTarget<_header.Header>('header'),
    _copy_button.CopyButton: ClientTarget<_copy_button.CopyButton>(
      'copy_button',
      params: __copy_buttonCopyButton,
    ),
    _portal$page.PortalCard: ClientTarget<_portal$page.PortalCard>(
      'portal.page',
      params: __portal$pagePortalCard,
    ),
  },
  styles: () => [
    ..._theme_toggle_button.ThemeToggleButtonState.styles,
    ..._codeblock$component.BlockCode.styles,
    ..._codeblock$component.InlineCode.styles,
    ..._file_tree$component.FileTree.styles,
    ..._heading_link$component.HeadingWithLink.styles,
    ..._toc_content$component.TocContentComponent.styles,
    ..._blog$layout.MochiBlogLayoutComponent.styles,
    ..._layout.MochiLayoutBaseComponent.styles,
    ..._toc$layout.MochiTocLayoutComponent.styles,
    ..._app.App.styles,
  ],
);

Map<String, Object?> __copy_buttonCopyButton(_copy_button.CopyButton c) => {
  'selectors': c.selectors,
};
Map<String, Object?> __portal$pagePortalCard(_portal$page.PortalCard c) => {
  'item': c.item.encode(),
};
