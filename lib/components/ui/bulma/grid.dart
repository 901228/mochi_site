import "package:jaspr/dom.dart" hide Gap;
import "package:jaspr/jaspr.dart";

class Gap {
  /// The value must be between 0 and 8.
  /// The actual gap is the value multiplied by 0.5rem.
  const Gap({int? row, int? column})
    : assert(row == null || (row >= 0 && row <= 8)),
      assert(column == null || (column >= 0 && column <= 8)),
      rowGap = row,
      columnGap = column;

  /// Creates a gap with the specified [rowGap] size.
  ///
  /// The value must be between 0 and 8.
  /// The actual gap is the value multiplied by 0.5rem.
  const Gap.row(int value) : assert(value >= 0 && value <= 8), rowGap = value, columnGap = null;

  /// Creates a gap with the specified [columnGap] size.
  ///
  /// The value must be between 0 and 8.
  /// The actual gap is the value multiplied by 0.5rem.
  const Gap.column(int value) : assert(value >= 0 && value <= 8), rowGap = null, columnGap = value;

  /// Creates a gap with the same size for both [rowGap] and [columnGap].
  ///
  /// The value must be between 0 and 8.
  /// The actual gap is the value multiplied by 0.5rem.
  const Gap.all(int value) : assert(value >= 0 && value <= 8), rowGap = value, columnGap = value;

  /// The value must be between 0 and 8.
  /// The actual gap is the value multiplied by 0.5rem.
  final int? rowGap;

  /// The value must be between 0 and 8.
  /// The actual gap is the value multiplied by 0.5rem.
  final int? columnGap;

  String get value {
    if (rowGap == null && columnGap == null) {
      return "";
    } else if (rowGap == null) {
      return "is-column-gap-$columnGap";
    } else if (columnGap == null) {
      return "is-row-gap-$rowGap";
    } else if (rowGap == columnGap) {
      return "is-gap-$rowGap";
    } else {
      return "is-row-gap-$rowGap is-column-gap-$columnGap";
    }
  }
}

class Grid extends StatelessComponent {
  const Grid({super.key, required this.children, this.minimumColumnWidth, this.gap})
    : assert(minimumColumnWidth == null || (minimumColumnWidth >= 0 && minimumColumnWidth <= 32));

  final List<Component> children;

  /// The minimum width of the grid columns.
  ///
  /// The value must be between 0 and 32.
  /// The actual width is the value multiplied by 1.5rem.
  final int? minimumColumnWidth;

  final Gap? gap;

  @override
  Component build(BuildContext context) {
    return div(
      classes:
          "grid"
          " ${minimumColumnWidth == null ? "" : "is-col-min-$minimumColumnWidth"}"
          " ${gap?.value ?? ""}",
      [
        for (final child in children) div(classes: "cell", [child]),
      ],
    );
  }
}
