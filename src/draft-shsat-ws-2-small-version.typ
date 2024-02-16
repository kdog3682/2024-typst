#set page(margin: 0.75in, paper: "us-letter")

#let dialogue-item() = {
  lorem(30)
  parbreak()
  linebreak()
}

#set text(size: 12pt)

#let holder(..items) = {
  enum(..items)
}
#{
  
  let num = 1
  let a = block({
      lorem(20)
  })
  let b = block({
      let letters = "ABCD"
      set enum(numbering: (it) => {
          let x = letters.at(it - 1) + "."
        text(weight: "bold", x)
      }, spacing: 39pt, tight: false, body-indent: 10pt)
      enum(
        lorem(3),
        lorem(3),
        lorem(3),
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
  
  
  

  v(20pt)

  show par: set block(spacing: 0.7em)
  //set par(leading: 2.3em)
  // doesnt do anything
  dialogue-item()
  dialogue-item()
  dialogue-item()
}



#let flex(a, b) = {
    let widths = (150pt, auto)
    return block(breakable: false, 
        grid(column-gutter: 19pt, columns: widths, a, b)
    )
}

#let question-container(title, body) = {
  // aasdasd

  let header = {
    let expr = box([*Q#question.number* -- *#question.source*\ ])
    
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
  rect(stroke: (dash: "dotted"), radius: 20pt, inset: 20pt, {
      header
      body
  })
}
