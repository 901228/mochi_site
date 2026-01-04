// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:mochi_site/components/layout/header.dart' as _header;
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
    _portal$page.PortalCard: ClientTarget<_portal$page.PortalCard>(
      'portal.page',
      params: __portal$pagePortalCard,
    ),
  },
  styles: () => [..._app.App.styles],
);

Map<String, Object?> __portal$pagePortalCard(_portal$page.PortalCard c) => {
  'item': c.item.encode(),
};
