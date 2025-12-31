// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:mochi_portal/components/circular_progreess_indicator.dart'
    as _circular_progreess_indicator;
import 'package:mochi_portal/components/header.dart' as _header;
import 'package:mochi_portal/components/portal.dart' as _portal;
import 'package:mochi_portal/pages/portal.dart' as _pages_portal;
import 'package:mochi_portal/app.dart' as _app;

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
    _portal.PortalCard: ClientTarget<_portal.PortalCard>(
      'portal',
      params: __portalPortalCard,
    ),
  },
  styles: () => [
    ..._circular_progreess_indicator.CircularProgressIndicator.styles,
    ..._header.Header.styles,
    ..._pages_portal.Portal.styles,
    ..._app.App.styles,
  ],
);

Map<String, Object?> __portalPortalCard(_portal.PortalCard c) => {
  'portal': c.portal.encode(),
  'flavorTheme': c.flavorTheme?.encode(),
};
