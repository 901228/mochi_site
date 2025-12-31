// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/client.dart';

import 'package:mochi_portal/components/portal.dart' deferred as _portal;
import 'package:mochi_portal/theme/_catppuccin/base.dart' as _base;

/// Default [ClientOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.client.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultClientOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ClientOptions get defaultClientOptions => ClientOptions(
  clients: {
    'portal': ClientLoader(
      (p) => _portal.PortalCard(
        portal: _portal.PortalItem.decode(p['portal'] as Map<String, dynamic>),
        flavorTheme: p['flavorTheme'] != null
            ? _base.FlavorTheme.decode(p['flavorTheme'] as Map<String, dynamic>)
            : null,
      ),
      loader: _portal.loadLibrary,
    ),
  },
);
