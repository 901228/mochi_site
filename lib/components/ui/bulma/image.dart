import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";
import "package:uuid/uuid.dart";

import "modal.dart";

enum Size { is16by16, is24by24, is32by32, is48by48, is64by64, is96by96, is128by128 }

enum Ratio {
  square,
  is1by1,
  is5by4,
  is4by3,
  is3by2,
  is5by3,
  is16by9,
  is2by1,
  is3by1,
  is4by5,
  is3by4,
  is2by3,
  is3by5,
  is0by16,
  is1by2,
  is1by3,
}

extension on Enum {
  String get getClass => " is-${name.replaceAll("is", "")}";
}

class Image extends StatelessComponent {
  const Image({
    super.key,
    this.classes,
    this.imageStyles,
    required this.src,
    this.alt,
    this.showCaption = false,
    this.rounded = false,
    this.size,
    this.ratio,
  }) : isZoomable = false;
  const Image.zoomable({
    super.key,
    this.classes,
    this.imageStyles,
    required this.src,
    this.alt,
    this.showCaption = true,
    this.rounded = false,
    this.size,
    this.ratio,
  }) : isZoomable = true;

  final String? classes;
  final String src;
  final String? alt;
  final bool showCaption;
  final bool isZoomable;
  final bool rounded;
  final Size? size;
  final Ratio? ratio;
  final Styles? imageStyles;

  @override
  Component build(BuildContext context) {
    if (!isZoomable) {
      return figure(
        classes:
            "image $classes"
            "${size?.getClass ?? ""}"
            "${ratio?.getClass ?? ""}",
        [
          img(classes: rounded ? "is-rounded" : "", src: src, alt: alt, styles: imageStyles),
          if (showCaption && alt != null) figcaption([.text(alt!)]),
        ],
      );
    } else {
      final String imageModalUuid = Uuid().v4();

      return .fragment([
        figure(
          classes:
              "image $classes"
              "${size?.getClass ?? ""}"
              "${ratio?.getClass ?? ""}",
          [
            button(
              classes: "js-modal-trigger",
              attributes: {"data-target": imageModalUuid},
              [img(classes: rounded ? "is-rounded" : "", src: src, alt: alt, styles: imageStyles)],
            ),
            if (showCaption && alt != null) figcaption([.text(alt!)]),
          ],
        ),

        Modal(
          id: imageModalUuid,
          child: p(
            classes:
                "image $classes"
                "${size?.getClass ?? ""}"
                "${ratio?.getClass ?? ""}",
            [img(classes: rounded ? "is-rounded" : "", src: src, alt: alt, styles: imageStyles)],
          ),
        ),
      ]);
    }
  }
}
