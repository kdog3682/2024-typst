#import "base-utils.typ": *
#import "styles.typ"

// each dialogue item should be a full-width item
// when you 
// unless using a 2 column layout ... then should be half width
// and the name should be placed vertically above
#let render-dialogue(data) = {
  let scope = (
    finale: (x) => rect(..styles.finale, str(x))
  )
  let runner(item) = {
    let a = heading(item.speaker, level: 3)
    let b = markup(item.text, scope)
    if has(item, 'question') {
        let c = render-question(item)
        return (a, block(c, b))
    }
    return (a, b)
  }
  let items = data.map(runner).flatten()
  table(..items)
}

#render(json("dialogue.json"))

let render-question(item) = {
    return mc-item(..item)

    let source = item.at('source', default: none)
    let question = item.at('question', default: none)
    let answers = item.at('answers', default: none)
    let choices = item.at('choices', default: none)
    if choices != none {
        
    }
    let markdown = markup(question)
    // add the ability to make it go
    // todo the tables ...
}

// the mc-item does not have its own numbering
// this is correct
#let mc-item(question, choices, answer, src: none, topic: none, layout: 'vertical', letters: 'ABCD', fill: none) {
  
  let num = 1
  let top = {

    let expr = if has(src, 'qnum') {
        box([*Q#src.qnum* -- *#src.exam*\ ])
    } else {
        bold(src)
    }
    
    expr 

    if topic != none {
        h(1fr)
        box(text(fill: blue, blue-emph(topic)))
    }
      
    if topic != none or src != none {
        v(-5pt)
        line(length: 100%)
    }
  }
  let vertical = layout == 'vertical'
  let scope = (:)
  let styles = if vertical {
      (:)
  } else {
      (width: 275pt)
  }
  // this is the question
  let a = block(..styles, markup(question))

  // these are the choices
  let b = block({
      // this is really cool
      // it implies you can use any item for the enum numbering
      // doesnt have to abcd or even letters for that matter
      set enum(numbering: (it) => {
          let x = letters.at(it - 1) + "."
        text(weight: "bold", x)
      }, spacing: 15pt, tight: false, body-indent: 10pt)

      enum(choices.map((x) => markup(x, scope)))
  })

  let val = if vertical {
  } else {
      block(breakable: false, fill: fill, grid(column-gutter: 20pt, columns: (300pt, 1fr), a, b))
  }
}

#let blue-emph(s) = {
    return emph(text(size: 8pt, resolve-text(s)))
}
