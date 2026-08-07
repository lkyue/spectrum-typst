#import "@preview/theorion:0.6.0": *
#import "@preview/showybox:2.0.4": showybox
#import "utils.typ": *

#set-qed-symbol[#math.qed]

#let thm-numbering-state = state("spectrum-thm-numbering", true)
#let show-prefix(prefix, supplement-map) = context {
  let s = theorion-i18n(supplement-map)
  if thm-numbering-state.get() { prefix } else { s }
}

#let colors = (
  "theorem":    rgb("#3D5A8C"),
  "lemma":      rgb("#4A7A6B"),
  "definition": rgb("#5A8A9C"),
  "example":    rgb("#B8863A"),
  "remark":     rgb("#8B6B9E"),
  "problem":    rgb("#B8554A"),
)

#let thmprefix(t, color: rgb("#000000")) = {
  text(font: (en-font-sans, cn-font-sans), weight: 650, fill: color)[#t]
}
#let thmtitle(t, color: rgb("#000000")) = {
  text(font: (en-font-sans, cn-font-sans), weight: 350, fill: color)[#t]
}
#let thmtext(t, color: rgb("#000000")) = {
  if t.has("children") and t.children.len() > 0 {
    let c = t.children
    if c.first() == [ ] {
      t = c.slice(1).join()
    }
  }
  text(font: (en-font-serif, cn-font-serif), fill: color)[#t]
}

#let rect-box-style(prefix: auto, title: "", full-title: auto, fill: luma(500), supplement: "", body) = {
  let titlefmt = thmtitle.with(color: fill.darken(30%))
  let bodyfmt = thmtext.with(color: fill.darken(70%))
  let prefixfmt = thmprefix.with(color: fill.darken(30%))

  showybox(
    width: 100%,
    radius: 0.3em,
    breakable: true,
    padding: (top: 0em, bottom: 0em),
    frame: (
      body-color: fill.lighten(96%).transparentize(50%),
      border-color: fill.darken(10%),
      thickness: (left: 3pt),
      inset: 1em,
      radius: 0em,
    ),
    [
      #set par(first-line-indent: 2em)
      #block[
        #prefixfmt(show-prefix(prefix, supplement)) #titlefmt(title)
      ]
      #bodyfmt(body)
    ],
  )
}

#let round-box-style(prefix: auto, title: "", full-title: auto, fill: luma(500), supplement: "", body)={
  let titlefmt = thmtitle.with(color: white)
  let bodyfmt = thmtext
  let prefixfmt = thmprefix.with(color: white)

  showybox(
    title:[#prefixfmt(show-prefix(prefix, supplement)) #titlefmt(title)],
    width: 100%,
    radius: 0.3em,
    breakable: true,
    frame: (
      title-color:fill,
      border-color: fill.darken(10%),
    ),
    shadow:(
      color:luma(220),
      offset:3pt
    ),
    [
      #set par(first-line-indent: 2em)
      #bodyfmt(body)
    ],
  )
}

#let line-box-style(prefix: auto, title: "", full-title: auto, fill: luma(500), supplement: "", body)={
  let titlefmt = thmtitle.with(color: black)
  let bodyfmt = thmtext
  let prefixfmt = thmprefix.with(color: black)

  showybox(
    title:[#prefixfmt(show-prefix(prefix, supplement)) #titlefmt(title)],
    width: 100%,
    breakable: true,
    frame: (
      title-color:none,
      border-color: fill.darken(10%),
      radius:0em
    ),
    [
      #set par(first-line-indent: 2em)
      #bodyfmt(body)
    ],
  )
}

#let (theorem-counter, theorem-box, theorem, show-theorem) = make-frame(
  "theorem",
  theorion-i18n-map.at("theorem"),
  counter: theorem-counter, // inherit the old counter, `none` by default
  inherited-levels: 2, // useful when you need a new counter
  inherited-from: heading, // heading or just another counter
  // render: rect-box-style.with(fill: colors.at("theorem")),
  render: line-box-style.with(fill: colors.at("theorem"), supplement: theorion-i18n-map.at("theorem")),
)

#let (definition-counter, definition-box, definition, show-definition) = make-frame(
  "definition",
  theorion-i18n-map.at("definition"),
  inherited-levels: 2,
  inherited-from: heading,
  // render: rect-box-style.with(fill: colors.at("definition")),
  render: round-box-style.with(fill: colors.at("definition"), supplement: theorion-i18n-map.at("definition")),

)

#let (lemma-counter, lemma-box, lemma, show-lemma) = make-frame(
  "lemma",
  theorion-i18n-map.at("lemma"),
  inherited-levels: 2,
  inherited-from: heading,
  render: rect-box-style.with(fill: colors.at("theorem"), supplement: theorion-i18n-map.at("lemma")),
)

#let (example-counter, example-box, example, show-example) = make-frame(
  "example",
  theorion-i18n-map.at("example"),
  inherited-levels: 2,
  inherited-from: heading,
  render: rect-box-style.with(fill: colors.at("example"), supplement: theorion-i18n-map.at("example")),
)

#let (remark-counter, remark-box, remark, show-remark) = make-frame(
  "remark",
  theorion-i18n-map.at("remark"),
  inherited-levels: 2,
  inherited-from: heading,
  render: rect-box-style.with(fill: colors.at("remark"), supplement: theorion-i18n-map.at("remark")),
)

#let (property-counter, property-box, property, show-property) = make-frame(
  "property",
  theorion-i18n-map.at("property"),
  inherited-levels: 2,
  inherited-from: heading,
  render: rect-box-style.with(fill: colors.at("theorem"), supplement: theorion-i18n-map.at("property")),
)

#let (problem-counter, problem-box, problem, show-problem) = make-frame(
  "problem",
  theorion-i18n-map.at("problem"),
  inherited-levels: 2,
  inherited-from: heading,
  render: rect-box-style.with(fill: colors.at("problem"), supplement: theorion-i18n-map.at("problem")),
)


#let show-thmenv(body) = {
  show: show-theorem
  show: show-lemma
  show: show-definition
  show: show-property
  show: show-remark
  show: show-example
  show: show-problem
  body
}
