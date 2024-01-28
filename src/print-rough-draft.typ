#let print-rough-draft(json) = {
  
  set page(paper: "us-letter", columns: 2, margin: 0.25in, numbering: "1")
  set text(size: 11pt)
  set par(leading: 1.5em)

  grid(columns: 2, column-gutter: 15pt, 
    align(block(fill: white, {
      text(style: "normal", size: 18pt, weight: "bold", json.title)
      if json.subtitle {
          v(-10pt)
          text(style: "normal", size: 11pt, weight: "bold", json.subtitle, font: "Barlow")
      }
  }), left), {
    align(horizon, block(fill: white, {
      if 1 == 2 {
        [hiasd\ ]
      }
    }))
  }
  )
  line(length: 100%, stroke: (dash: "dotted"))

  for paragraph in json.body {
    text(paragraph)
    v(20pt)
    // u can just place the paragraph like this ?
    // explicitly set the text
    // you can use negative lengths
    // line(length: 50%, stroke: (paint: blue, thickness: 0.5pt, dash: "loosely-dotted"))
  }
}

let json = read('/home/kdog3682/2024/abc.json')
#show: print-rough-draft(json)


// boxes make the content fit inside the rules of inline content
// blocks force content to be blocky
// align can be functionally declared about anywhere. (takes an alignment)
// a color scheme can be placed in.
