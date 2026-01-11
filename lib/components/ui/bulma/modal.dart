import "package:jaspr/dom.dart";
import "package:jaspr/jaspr.dart";

class Modal extends StatelessComponent {
  const Modal({super.key, this.id, required this.child}) : head = null, body = null, foot = null;
  const Modal.card({super.key, this.id, this.head, this.body, this.foot}) : child = null;

  final String? id;
  final Component? child;
  final Component? head;
  final Component? body;
  final Component? foot;

  @override
  Component build(BuildContext context) {
    return div(classes: "modal", id: id, [
      div(classes: "modal-background", []),
      if (child != null)
        div(classes: "modal-content", [child!])
      else
        div(classes: "modal-card", [
          if (head != null)
            header(classes: "modal-card-head", [
              p(classes: "modal-card-title", [head!]),
              button(classes: "delete", attributes: {"aria-label": "close"}, []),
            ]),
          if (body != null) section(classes: "modal-card-body", [body!]),
          if (foot != null) footer(classes: "modal-card-foot", [foot!]),
        ]),
      if (child != null) button(classes: "modal-close is-large", attributes: {"aria-label": "close"}, []),
    ]);
  }
}
