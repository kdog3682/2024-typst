
#let page-setup() = {
    
    return 
    // you can return functions ... that allow absolute placement
    // you can use anchoring systems
}
#let margin = 0.5in
#set page(margin: 0.5in, paper: "us-letter")

#{

  let width = 20pt
  let green-square = square(width, green)
  place(dx: -0.5in, dy: -0.5in, green-square)
  layout(x => {
    place(dx: x.width + margin - width, dy: -margin, green-square)
  })
  
  let b = [aaa]
  rect(width: 256pt, height: auto, fill: yellow.lighten(60%))
}


  // if you return the value ... it doesnt display on the page
