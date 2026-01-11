abstract class AppConfig {
  static const basePath = String.fromEnvironment("BASE_PATH", defaultValue: "/");

  static const isDev = String.fromEnvironment("ENVIRONMENT", defaultValue: "development") == "development";

  // static String assetPath(String path) {
  //   return "$basePath${path.startsWith("/") ? path.substring(1) : path}/";
  // }

  static String relativeRoute(String path) {
    if (path == "/") return "";

    if (path.startsWith("/")) path = path.substring(1);
    if (!path.endsWith("/")) path = "$path/";

    return path;
  }
}
