// documentation
// 
// functions:
// - zhuyin-atom
// - zhuyin-paragraph
// - zhuyin-sentence (array of parts)
// 
// usage: the main export is zhuyin-paragraph.
// it places all the zhuyin sentences which place the zhuyin atoms.

#import "base-utils.typ": *


#let ruler(s, k: 0.65) = {
  // there is another way to do this ruler
  // that is to build the text up from atoms (ala fpdf.py style)
  // but that becomes very imperative ... and i think it is wrong

  let value = text(s)
  let create(width) = {
    // the 'value' is closured and that is okay.
    return block(value, width: width * 1pt)
  }

  // this layout size refers to the current parent container
  // sometimes it refers to the page
  // most of the time, it will refer to a particular block
  style((styles) => layout(size => {
    let n = int(size.width.pt() * k)

    let b = create(n)
    let m = measure(b, styles)
    let height = m.height

    let temp = b
    let increment = 20

    for i in range(5) {
      n = n - increment
      temp = create(n)
      let m = measure(temp, styles)
      if m.height != height {
          if i == 0 {
              n += increment * 2
          } else {
              n = n + increment
          }
          break
      }
    }
    return create(n)
  }))
}


#let zhuyin-atom(top-item, bottom-item, scale: 0.45, gap: 0.55) = {
// #let zhuyin-atom(top-item, bottom-item, scale: 0.65, gap: 0.55) = {
    // scale (float): how much smaller the zhuyin (top) word should be 
    // gap (float)  : the distance between the top and bottom

   let table-item = table(
        align: center,                 // necessary
        columns: auto,                 // doesnt do anything
        inset: 0pt,                    // necessary: squeezes the table
        stroke: none,                  // necessary: hides the border
        row-gutter: 1em * gap,
        text(1em * scale, top-item),
        bottom-item,
    )
    return box(table-item)             // box makes the item inline
}


#let zhuyin-paragraph(sentences) = {
    for sentence in sentences {
        zhuyin-sentence(sentence)
    }
}

#let zhuyin-sentence(parts) = {
  // multiple sentences may be comprised here in a single line
  // the word sentence could perhaps be paragraph
  // no linebreaks are initiated her
  let spacer-punctuation = h(0.1em)
  let spacer-word = h(0.2em)

  for part in parts {
    zhuyin-atom(part.pinyin, part.text)

    if has(part, "punctuation") and part.punctuation != part.text {
        part.punctuation
    }

    if not is-last(part, parts) {
        if has(part, "punctuation") {
            spacer-punctuation
        } else {
            spacer-word
        }
        spacer-word
    }
  }
}
// #let a = zhuyin-atom("nihao", "你好")
// #panic(a)


#let zhuyin-sentence-3(o) = {

  let spacer-punctuation = h(0.1em)
  let spacer-word = h(0.2em)

  for token in o.tokens {
    let chinese = token.at("chinese", default: none)
    if empty(chinese) {
        let punc = token.at("punctuation")
        text(punc)
        if token.pos == "middle" {
            spacer-punctuation
        }
        // else if token.pos == "middle" {
            // h(0.1em)
        // }
    } else {
        let punc = token.at("punctuation", default: none)
        zhuyin-atom(token.pinyin, token.chinese)

        if punc != none {
            text(punc)
            if token.pos == "middle" {
                spacer-punctuation
            }
        } else {
            if token.pos != "end" {
                spacer-word
            }
        }
    }
  }
}


#let zhuyin-wrapper(sentence, width: 75) = {
    let attrs = (
        above: 0pt,
        below: 0pt,
    )
    let a = block(..attrs, sentence, width: 88% +8%)
    return a
    let a = block(..attrs, sentence, width: (width) * 1%)
    let b = block(..attrs, sentence, width: (width + 20) * 1%)
    style(styles => {
        let measurement-a = measure(a, styles)
        let measurement-b = measure(b, styles)
        if measurement-a.height == measurement-b.height {
            a
        } else {
            b
        }
    })
}


#let zhuyin-sentence-chunk(o, k:0.50, leading: 0.95em) = {
    if has(o, "linebreak") {
        let dotted = (
          stroke: (
              thickness: 0.5pt,
              dash: "loosely-dotted",
          )
        )
        align(center, line(length: 100%, ..dotted))
    } else {
        // zhuyin-wrapper(zhuyin-sentence-3(o), width: 65)
        // with the atom
        // creates the pinyin effect

        set par(leading: leading)
        ruler(o.text, k: k)
    }
}
