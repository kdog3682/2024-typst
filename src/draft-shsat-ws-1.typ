#import "page-templates.typ"


page-templates.test.with(fill: black)

#let holder(..items) = {
  enum(..items)
}
#{
  
  let num = 1
  let top = {
    let expr = box([*Q17* -- *Kaplan Exam 2012*\ ])
    
    expr 
    h(1fr)
    box({
      text(fill: blue, emph("percentages"))
      //rect(outset: 0pt, radius: 5pt, inset: 5pt, text(size: 8pt, "percentages"))
    })
      
    v(-5pt)
    //line(length: 170pt)
    line(length: 100%)
  }
  let a = block({
      lorem(60)
  })
  let b = block({
      let letters = "ABCD"
      set enum(numbering: (it) => {
          let x = letters.at(it - 1) + "."
        text(weight: "bold", x)
      }, spacing: 39pt, tight: false, body-indent: 10pt)
      enum(
        lorem(30),
        lorem(30),
        lorem(30),
      )
  })
  let val = block(breakable: false, fill: yellow.lighten(100%), grid(column-gutter: 19pt, columns: (170pt, 1fr), a, b))
  
  set enum(full: false, numbering: (x) => {
    text(weight: "bold", str(x) + ".")
  }, tight: false, spacing: 40pt)
  //holder(val, val, val)

  // v(-30pt)
  [= Extra SHSAT Math Practice ]
  v(0pt)

  let name = [Michelle]
  let names = [Michelle Chen | Alvin | Hao Xiang Chen]
  let grouping = [
    
    *Student Group*: #names
  ]
  
  style(styles => {
    let length = measure(grouping, styles).width
    //line(stroke: (dash: "loosely-dotted"), length: length)
  })
  grouping
  v(40pt)
  
  
  
  rect(stroke: (dash: "dotted"), radius: 20pt, inset: 20pt, {
    top
    val
  })
}

#let tabler(params) = {
  table(
  fill: (col, _) => if calc.odd(col) { luma(240) } else { white },
  align: (col, row) =>
    if row == 0 { center }
    else if col == 0 { left }
    else { right },
  columns: 4,
  [], [*Q1*], [*Q2*], [*Q3*],
  [Revenue:], [1000 €], [2000 €], [3000 €],
  [Expenses:], [500 €], [1000 €], [1500 €],
  [Profit:], [500 €], [1000 €], [1500 €],
)
}
