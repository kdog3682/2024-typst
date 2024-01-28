// documents the last touched online typ stuff



#let o = (0,0)
#let p34 = (3, 4)
#import "@preview/cetz:0.2.0"
#cetz.canvas({
  import cetz.draw: *

  let red-circle(pos) = {
    circle(pos, radius: 5pt, fill: red, stroke: none)
  }
  let grid-line(a, b) = {
    line(a, b, name: "holder", stroke: none)
  }

  let arrow(a, b) = {
    let arrow-attrs = (
      mark: (
        start: ">",
        fill: black,
        length: 3pt,
      ),
      stroke: (
        paint: black,
        dash: "dotted"
      )
    )
    line(a, b, ..attrs)
  }

  rect(
    name: "rec",
    o,
    p34,
    stroke: (thickness: 0.5pt, dash: "dotted"),
  )

  rect(
    name: "half",
    fill: yellow.lighten(80%),
    stroke: (thickness: 0.5pt, dash: "dotted"),
    "rec.north-west",
    "rec.south"
  )
  grid-line("rec.north", "rec.center")
  red-circle("rec.north-east")
  red-circle("rec.center")
  red-circle("holder.mid")
  arrow("rec.center", "holder.mid")

  content(o, {
    v(30pt)
    block(above: 20pt, {
      [
        hi
        hi\
        hi\
      ]
    })
  })
})

