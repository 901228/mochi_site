abstract class AppConfig {
  static const basePath = String.fromEnvironment("BASE_PATH", defaultValue: "/");

  static const isDev = String.fromEnvironment("ENVIRONMENT", defaultValue: "development") == "development";

  static String assetPath(String path) {
    return '$basePath${path.startsWith('/') ? path.substring(1) : path}';
  }
}
