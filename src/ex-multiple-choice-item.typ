#set page(margin: 1in)

#set text(size: 12pt)

#let holder(..items) = {
  enum(..items)
}
#{
  
  let num = 1
  let a = lorem(60)
  let b = block({
      let letters = "ABCD"
      set enum(numbering: (it) => {
          letters.at(it - 1)
      }, spacing: 20pt, tight: false, body-indent: 10pt)
      enum(
        rect(lorem(30)),
        rect(lorem(30)),
        rect(lorem(30)),
      )
  })
  let val = block(fill: yellow, grid(column-gutter: 20pt, columns: (170pt, 1fr), a, b))
  set enum(full: false, numbering: (x) => {
    text(weight: "bold", str(x) + ".")
  })
  holder(val, val)
}
