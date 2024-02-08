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
    let mmgg-inline-icon = create-icon-factory("../mmgg-assets/")
    let cat = mmgg-inline-icon("cat", size: 20)
    let dog = mmgg-inline-icon("puppy", size: 20)

    set text(lang: "zh")
    let margin = (
      top: 1in,
      left: 1in,
      right: 1in,
      bottom: 1.25in,
    )
    set page(paper: "us-letter", margin: margin)
    // set page(footer-descent: 0pt)
    // we want the footer to descend a little bit
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
