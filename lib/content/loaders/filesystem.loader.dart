import "dart:async";

import "package:file/file.dart";
import "package:file/local.dart";
import "package:jaspr_content/jaspr_content.dart";

class MochiFilesystemLoader extends FilesystemLoader {
  MochiFilesystemLoader(
    super.directory, {
    this.prefixPath,
    super.keepSuffixPattern,
    super.debugPrint,
    this.fileSystemMochi = const LocalFileSystem(),
  });

  final String? prefixPath;
  final FileSystem fileSystemMochi;

  @override
  Future<List<PageSource>> loadPageSources() async {
    final root = fileSystemMochi.directory(directory);
    if (!await root.exists()) {
      return [];
    }

    List<PageSource> loadFiles(Directory dir) {
      final List<PageSource> entities = [];
      for (final entry in dir.listSync()) {
        final path = entry.path.substring(root.path.length + 1);
        if (entry is File) {
          entities.add(
            FilePageSource(
              prefixPath == null ? path : "$prefixPath/$path",
              entry,
              this,
              keepSuffix: keepSuffixPattern?.matchAsPrefix(entry.path) != null,
              context: fileSystemMochi.path,
            ),
          );
        } else if (entry is Directory) {
          entities.addAll(loadFiles(entry));
        }
      }
      return entities;
    }

    return loadFiles(root);
  }
}
