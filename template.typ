#import "thmenv.typ": *
#import "utils.typ": *


#let note(title: "Sample", author: "John Doe", lecturer: "", institution: "", watermark: none, cover: true, body) = {
  set text(
    font: (
      en-font-serif,
      cn-font-serif,
    ),
    weight: "light",
  )

  show "。": ". "
  show: show-thmenv
  set table(fill: (r, c) => if calc.rem(r, 2) == 0 { luma(235) })

  set par(first-line-indent: 2em)
  set math.cases(gap: 0.5em)

  set page(
    numbering: "1",
    paper: "a4",
    margin: (x: 1.5cm, y: 1.5cm),
    header: context {
      let current-page = here().page()

      if current-page <= 1 { return }

      let has-heading = query(heading.where(level: 1)).any(it => it.location().page() == current-page)

      if current-page != 2 and has-heading { return }

      box(
        grid(
          columns: (1fr, 1fr),
          align: (horizon + left, horizon + right),
          text()[\- #here().page() -],
        ),
        inset: 4pt,
        stroke: (bottom: 0.5pt),
      )
    },
    footer: context {
      let current-page = here().page()

      let has-heading = query(heading.where(level: 1)).any(it => it.location().page() == current-page)

      if not has-heading { return }
      if current-page <= 1 { return }

      align(center)[\- #current-page -]
    },
  )

  set page(background: rotate(-60deg, text(100pt, fill: rgb("#faf2f1"))[
    #strong()[#watermark]
  ])) if watermark != "logo"

  set heading(numbering: "1.")

  show heading.where(level: 1): t => context {
    if t.body in ([Contents], [目录]) { return t }

    let chp = counter(heading).get().at(0)

    set text(size: 30pt, font: (en-font-serif, cn-font-serif))
    if chp > 1 {
      pagebreak() + [Chapter #chp \ #t.body \ ]
    } else {
      [Chapter #chp \ #t.body \ ]
    }
  }

  show heading.where(level: 2): t => context {
    counter(math.equation).update(0)
    set par(first-line-indent: 0em)
    set text(size: 18pt)

    [#counter(heading).display("1.1") #t.body]
  }

  show heading.where(level: 3): t => context {
    set par(first-line-indent: 0em)
    set text(size: 14pt)

    [#counter(heading).display("1.1.1") #t.body]
  }

  show math.equation: it => {
    if it.fields().keys().contains("label") {
      math.equation(
        block: true,
        numbering: n => {
          let count = counter(heading).get()
          let h1 = count.first()
          let h2 = count.at(1, default: 0)
          numbering("(1.1.1)", h1, h2, n)
        },
        it,
      )
    } else {
      it
    }
  }

  show ref: it => context {
    let el = it.element
    if el != none and el.func() == math.equation {
      let count = counter(heading).at(el.location())
      let h1 = count.first()
      let h2 = count.at(1, default: 0)
      let fmt = "Eq"
      if text.lang == "zh" { fmt = "式" }
      link(el.location(), numbering(
        fmt + " (1.1.1)",
        h1,
        h2,
        counter(math.equation).at(el.location()).at(0)
      ))
    } else {
      it
    }
  }

  if cover {
    let cover-page = {
      set page(footer: none, background: image("src/bg05.svg", width: 101%, fit: "cover"))

      set text(fill: white)
      set par(first-line-indent: 0pt)

      v(5fr)
      [
        #align(left)[#underline(
          (underline(text(size: 45pt, weight: 800)[#title], offset: 7pt, stroke: red)),
          stroke: red,
          offset: 11pt,
        )]
        #align(left)[
          #text(size: 30pt, weight: 800)[Revision Notes]
        ]
      ]
      v(1em)
      text(
        font: (en-font-sans, cn-font-sans),
        size: 14pt,
        weight: 800,
      )[#math.copyright #author]
      v(0.3em)
      if lecturer != "" {
        text(
          font: (en-font-sans, cn-font-sans),
          size: 12pt,
        )[Lecturer: #lecturer]
        v(0.3em)
      }
      if institution != "" {
        text(
          font: (en-font-sans, cn-font-sans),
          size: 12pt,
        )[#institution]
        v(0.3em)
      }
      text(
        font: (en-font-sans, cn-font-sans),
        size: 12pt,
      )[#datetime.today().display("[year]-[month padding:zero]-[day padding:zero]")]
      v(10fr)
    }

    cover-page

    pagebreak()

    outline(depth: 2)

    pagebreak()
  } else {
    set par(first-line-indent: 0pt)
    align(center)[
      #text(size: 24pt, weight: "bold")[#title]
      #v(0.5em)
      #text(size: 14pt, font: (en-font-sans, cn-font-sans))[#author]
      #v(0.3em)
      #if lecturer != "" {
        text(size: 12pt, font: (en-font-sans, cn-font-sans))[Lecturer: #lecturer]
        v(0.3em)
      }
      #if institution != "" {
        text(size: 12pt, font: (en-font-sans, cn-font-sans))[#institution]
        v(0.3em)
      }
      #text(size: 12pt, font: (en-font-sans, cn-font-sans))[#datetime.today().display("[year]-[month padding:zero]-[day padding:zero]")]
    ]
    v(2em)
    set par(first-line-indent: 2em)
    pagebreak()
  }
  
  body
}
