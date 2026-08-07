# spectrum-typst

A versatile Typst template for STEM notes, assignments, and lab reports.
Adapted from [@syqwq's notes-template](https://github.com/syqwq-OMG/notes-template).

## Features

- **Theorem environments** — theorem, lemma, definition, example, remark, property, proposition, problem, proof, solution
- **Auto QED placement** on proofs (via theorion)
- **CJK punctuation normalization** for mixed Chinese-English writing
- **i18n cover subtitle** — English and Chinese support
- **Multi-level headings** with auto-numbering
- **Striped tables** with alternating row colors
- **Equation numbering** scoped to sections
- **Two modes** — full cover page or compact header
- **Built-in packages** — `algo` (pseudocode), `cetz` (drawings), `unify` (unit formatting), `physica` (physics notation), `alchemist` (chemical structures)

## Installation

### As a local package (recommended)

Symlink the project into Typst's local package cache:

```bash
mkdir -p ~/Library/Caches/typst/packages/local/spectrum-typst/0.1.0
ln -sfn /path/to/spectrum-typst \
  ~/Library/Caches/typst/packages/local/spectrum-typst/0.1.0
```

On Linux, replace `~/Library/Caches/typst` with `~/.cache/typst`.

Then import in any `.typ` file:

```typst
#import "@local/spectrum-typst:0.1.0": *
```

### Copy to your project

Copy `template.typ`, `thmenv.typ`, `utils.typ`, and the `src/` folder into your project directory, then use relative imports:

```typst
#import "template.typ": *
```

## Quick Start

### With cover page (notes mode)

```typst
#import "@local/spectrum-typst:0.1.0": *

#show: note.with(
  "Course Title",
  "Author Name",
  lecturer: "Prof. Smith",
  institution: "University of Cambridge",
  cover: true,
)

= Chapter 1
== Section 1.1
Content goes here...
```

### Without cover (assignment / lab report mode)

```typst
#import "@local/spectrum-typst:0.1.0": *

#show: note.with(
  "Lab Report 3",
  "Author Name",
  lecturer: "Prof. Smith",
  institution: "MIT",
  cover: false,
)

= Introduction
Content goes here...
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title` | `str` | *required* | Document title |
| `author` | `str` | *required* | Author name |
| `lecturer` | `str` | `""` | Lecturer name (hidden if empty) |
| `institution` | `str` | `""` | Institution name (hidden if empty) |
| `watermark` | `str` | `none` | Background watermark text |
| `cover` | `bool` | `true` | Full cover page + TOC if `true`, compact header if `false` |
| `lang` | `str` | `"en"` | Language for i18n (`"en"`, `"zh"`) |
| `subtitle` | `str` | `auto` | Cover subtitle (`auto` uses i18n default) |
| `body` | `content` | *required* | Document content |

## Theorem Environments

```typst
#theorem(title: "Pythagorean Theorem")[
  $a^2 + b^2 = c^2$
]

#proof[
  By rearrangement of squares.
]

#definition[
  A _group_ is a set with an associative binary operation...
]

#lemma[Every subgroup is non-empty.]

#example(title: "Gaussian Elimination")[
  Solve $A x = b$ for $A in bb(R)^(n times n)$.
]

#problem[
  Prove that $sqrt(2)$ is irrational.
]

#solution[
  Assume $sqrt(2) = p/q$ in lowest terms...
]
```

## Optional Packages

The template is designed to work seamlessly with these Typst packages:

```typst
#import "@preview/algo:0.3.6"           // Pseudocode
#import "@preview/alchemist:0.2.0": *   // Chemical structures
#import "@preview/cetz:0.5.2": canvas, draw  // Vector graphics
#import "@preview/unify:0.8.1"          // Unit formatting
#import "@preview/physica:0.9.8": *     // Physics notation
```

See `main.typ` for a comprehensive example.

## Background Credits

- @Mohamed_hassan on Pixabay
- @yayangart on Pixabay

## License

MIT
