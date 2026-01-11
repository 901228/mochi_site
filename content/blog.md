---
title: Building blogs with Jaspr 來點中文
description: ""
categories: ["test", "root"]
tags: ["Dart", "Jaspr", "Blog"]
date: 2025-04-26
---

## Welcome to Jaspr Content 2

This is a sample content file. You can add more files here as needed.

---

All standard **markdown syntax** is supported, including:

**Lists**:

- Item 1
- Item 2
  1. Nested item
  2. Nested item 2

### Blockquotes

> This is a blockquote.
> It can span multiple lines.

### Code blocks

```dart
void main() {
    // 你好
    print('Hello, world!');
}
```

### Callouts
> [[!NOTE]]
> Highlights information that users should take into account, even when skimming.

> [[!INFO]]
> Optional information to help a user be more successful.

> [[!IMPORTANT]]
> Crucial information necessary for users to succeed.

> [[!WARNING]]
> Critical content demanding immediate user attention due to potential risks.

> [[!CAUTION]]
> Negative potential consequences of an action.

**Inline code**: Use `print('Hello, world!')` to display a message.

<FileTree>

- lib/
  - components/
    - clicker.dart
  - **main.dart** Highlighted file with comment
- tool/
- .gitignore
- analysis_options.yaml
- CHANGELOG.md
- LICENSE
- package.yaml
- README.md This is a comment

</FileTree>

**Links**: [Visit Jaspr](https://jaspr.dev)

**Images**: ![Sample Image](https://placehold.co/600x400)

**Tables**:

| Syntax   | Description |
| -------- | ----------- |
| Header 1 | Content 1   |
| Header 2 | Content 2   |
