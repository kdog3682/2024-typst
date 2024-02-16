#import "base-utils.typ": *
#import "prose.typ": prose-ref




// simple components

#let multiple-choice(
    show-answer: false,
    answer: "aaa",
    lettering: "abcd",
    choices: ("a", "b", "aaa", "xxx"),
    layout: "vertical",
    question
) = {

    let letters = "ABCD"
    let answerIndex = if exists(answer) { choices.position((x) => x == answer) } else { none }
    set enum(numbering: (it) => {
        let curIndex = it - 1
        let index = letters.at(curIndex)
        let indexContent = bold(index + ".")
        indexContent
        return 
        if answerIndex != none and curIndex == answerIndex {
            box(indexContent, fill: green.lighten(70%), radius: 50%, 
            inset: 3pt)
        } else {
            indexContent
        }
        
    }, spacing: 20pt, tight: false, body-indent: 10pt)

    let trax((i, item)) = {
        return if answerIndex == i {
            text(weight: "bold", fill: green.lighten(25%), item)
        } else {
            item
        }
    }
    let choicesContent = enum(..choices.map(markup).enumerate().map(trax))

    question
    v(10pt)
    choicesContent

    // let val = block(fill: yellow, grid(column-gutter: 20pt, columns: (170pt, 1fr), a, b))
}
// #mc([hi])



#{
  // [aaa]
  // flex(lorem(55), lorem(18), lorem(36))
  // [bbb]
}

// #math-front-matter(title: "hi", aaa: "bo")
