#let mmgg-title = (
    size: 18pt, weight: "bold"
)

#let chess-piece-size = (
   width: 10pt, height: 10pt
)

#let dash-stroke = (thickness: 0.5pt, dash: "dotted")
#let finale = (
  stroke: (thickness: 0.5pt, dash: "dotted"),
  inset: 3pt,
)
#let strokes = (
  soft: (dash: "loosely-dotted", thickness: 0.5pt, paint: black),
  hard: (dash: "loosely-dotted", thickness: 0.5pt, paint: black),
)

let soft-mark = (
    width: 0.2,
    length: 0.3,
    stroke: strokes.soft,
    start: ">",
    end: ">",
    fill: black,
)




#let text-attrs = (
  weight: "bold",
  size: 18pt,
  centered: true,
)

#let get(key) = {
    
}



// #panic(chess-piece)


/*
  rect(stroke: black, fill: white, radius: 5pt, align(text(size: 0.6em, fill: color, weight: "bold", key)))
small-black-circle
  stroke
  fill

size: 0.6em, fill: color, weight: "bold"


  let stroke = 0.3pt
  let stroke = 0.3pt
  let align = center + horizon
  let align=auto
   table(column-gutter: gap, columns: items.len(), stroke: stroke, align: align, inset: 0pt, ..items)
width: 300pt, height: 300pt, background: rect(fill: white, width: 100%, height: 100%))


  dialogue-right
    left
    right
    top
    bottom
*/
