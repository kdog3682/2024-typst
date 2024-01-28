#import "base-utils.typ": *

#let mmgg-template(doc, ..sink) = {
    let footer-title = [猫猫和狗狗的故事]
    let base-kwargs = (
      footer-title: footer-title,
      font-size: 12pt,
      title: "placeholder-title"
    )

    let kwargs = merge(base-kwargs, sink.named())
    // kwargs.insert("footer-title", "")
    let mmgg-create-icon = create-icon-factory("../mmgg-assets/", ext: "png")
    let attrs = (
        size: 20,
    )
    let mmgg-inline-icon = mmgg-create-icon(..attrs)
    let cat = mmgg-inline-icon("cat")
    let dog = mmgg-inline-icon("puppy")

    set text(lang: "zh")
    set page(paper: "us-letter", margin: 1in)

    set page(footer-descent: 0pt)
    set page(footer: {
      counter(page).display(number => {
        let num = sm-text(number)
        let ft = sm-text(kwargs.footer-title)
        if number > 1 {
            if calc.odd(number) {
              flex(cat, [— #num —], dog)
            } else {
              flex(dog, [— #num —], cat)
            }
        } else {
            if calc.odd(number) {
              flex((dog, cat), [— #num —], ft)
            } else {
              flex((cat, dog), [— #num —], ft)
            }
        }
      })
    })

    // set text(font: "Noto Serif CJK HK")
    // set text(font: "Noto Sans CJK SC")
    set text(font: "Noto Serif CJK SC")
    set text(size: kwargs.font-size)


    title(kwargs.title)
    doc
}

// #mmgg-template([hi #pagebreak() hi])



// Notes:

the layout of the footer is still a little off 
