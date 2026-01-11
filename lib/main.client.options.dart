// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/client.dart';

import 'package:mochi_site/components/layout/header.dart' deferred as _header;
import 'package:mochi_site/components/ui/copy_button.dart'
    deferred as _copy_button;
import 'package:mochi_site/pages/portal.page.dart' deferred as _portal$page;

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
    'header': ClientLoader(
      (p) => _header.Header(),
      loader: _header.loadLibrary,
    ),
    'copy_button': ClientLoader(
      (p) => _copy_button.CopyButton(selectors: p['selectors'] as String),
      loader: _copy_button.loadLibrary,
    ),
    'portal.page': ClientLoader(
      (p) => _portal$page.PortalCard(
        item: _portal$page.PortalItem.decode(p['item'] as Map<String, dynamic>),
      ),
      loader: _portal$page.loadLibrary,
    ),
  },
);
