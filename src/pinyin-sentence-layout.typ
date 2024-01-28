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


#let zhuyin-atom(top-item, bottom-item, scale: 0.65, gap: 0.55) = {
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
  let spacer-punctuation = h(0.2em)
  let spacer-word = h(0.2em)
  for part in parts {
    zhuyin-atom(part.pinyin, part.text)
    if "punctuation" in part {
        part.punctuation
    }
    if not is-last(part, parts) {
        if "punctuation" in part and part.punctuation {
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
