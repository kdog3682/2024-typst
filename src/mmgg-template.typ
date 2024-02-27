#import "base-utils.typ": *
#import "layout.typ": flex-1
#import "typography.typ"

#let periodMark = box(
    inset: (left: 1pt, right: 0.5pt),
    circle(radius: 1.2pt, stroke: 0.3pt, fill: none)
)


#let exclamMark = box( inset: (left: 0.1em, right: 0.1em), text(size: 1.05em, font: "TeX Gyre Schola Math", [!]) )
#let questionMark = box( inset: (left: 0.1em, right: 0.1em), text(size: 1.1em, font: "TeX Gyre Schola Math", [?]) )
// #let questionMark = box(inset: (left: 0.2em, right: 0.2em), text(weight: "bold", size: 1.1em, font: "New Computer Modern Math", [?]))

#let ellipsesMarkCircle = box(
    circle(radius: 0.7pt, stroke: 0.3pt, fill: black)
)
#let makeEllipsesMark() = {
  let store = ()
  let ref = (
    start: (inset: (left: 1.2pt, right: 0.5pt)),
    end: (inset: (left: 0.5pt, right: 1pt)),
    middle: (inset: (left: 0.5pt, right: 0.5pt))
  )
  let get-key(i, n) = {
    if i == 0 {
      "start"
    } else if i == n - 1 {
      "end"
    } else {
      "middle"
    }
  }
  let circle-attrs = (
    stroke: 0.3pt,
    radius: 0.75pt
  )
  let n = 6
  for i in range(n) {
    let key = get-key(i, n)
    let inset = ref.at(key)
    let circ = box(..inset, circle(..circle-attrs))
    store.push(circ)
  }
  return store.join()
}

#let ellipsesMark = makeEllipsesMark()
#let exclamMark = box( inset: (left: 0.1em, right: 0.1em), text(size: 1.05em, font: "TeX Gyre Schola Math", [!]) )
#let commaMark = box( inset: (left: 0.0em, right: 0.1em), text(size: 1.05em, font: "TeX Gyre Schola Math", [,]) )



#let mmgg-template(doc, ..sink) = {
    let footer-title = [猫猫和狗狗的故事]
    let base-kwargs = (
      footer-title: footer-title,
      font-size: 12pt,
      title: "placeholder-title"
    )

    let kwargs = merge(base-kwargs, sink.named())
    // panic(kwargs)
    // kwargs.insert("footer-title", "")

    let icon-attrs = (
        ext: "png",
        key: "mmgg",
        size: 20,
    )
    let cat = create-icon("cat", ..icon-attrs)
    let dog = create-icon("puppy", ..icon-attrs)

    let margin = (
      top: 1in,
      left: 1in,
      right: 1in,
      bottom: 1.25in,
    )
    // set page(footer-descent: 0pt)
    // we want the footer to descend a little bit
    set page(footer: {
      counter(page).display(number => {
        let num = typography.sm-text(number)
        let ft = typography.sm-text(kwargs.footer-title)
        if number > 1 {
            if calc.odd(number) {
              flex-1(cat, [— #num —], dog)
            } else {
              flex-1(dog, [— #num —], cat)
            }
        } else {
            if calc.odd(number) {
              flex-1((dog, cat).join(""), [— #num —], ft)
            } else {
              flex-1((cat, dog).join(""), [— #num —], ft)
            }
        }
      })
    })

    // set text(font: "Noto Serif CJK HK")
    // set text(font: "Noto Sans CJK SC")

    set smartquote(enabled: false)
    set page(paper: "us-letter", margin: margin)
    set text(font: "Noto Serif CJK SC", lang: "zh")
    set text(size: kwargs.font-size)
    // set text(lang: "zn", font: "Noto Serif CJK HK")
    // set par(leading: 0.85em)
    // show par: set block(spacing: 1.0em)

    show "。": periodMark
    show "？": questionMark
    show "！": exclamMark
    show "，": commaMark
    show "…":  ellipsesMark
    // show "：": ":"
    // saving the colon for later

    let smaller = it => text(size: kwargs.englishNameSizing * 1em, it)
    show "Alice":  smaller
    show "Charlie":  smaller
    show "Emily":  smaller
    show "Sara":  smaller
    // quotes are being handled via utf-text
    // not showing :
    // not showing ;
    // not showing (
    // not showing )
    // not showing [
    // not showing ]
    // not showing {
    // not showing }
    // not showing %
    // panic(kwargs)

    typography.title(kwargs.title, class: "mmgg")
    doc
}
