/*
import cetz.chart
// Left - Basic
let data = (("A", 10), ("B", 20), ("C", 13))
group(name: "a", {
chart.columnchart(size: (4, 3), data)
})
// Center - Clustered
let data = (("A", 10, 12, 22), ("B", 20, 1, 7), ("C", 13, 8, 9))
group(name: "b", anchor: "south-west", {
anchor("default", "a.south-east")
chart.columnchart(size: (4, 3), mode: "clustered", value-key: (1,2,3), data)
})
// Right - Stacked
let data = (("A", 10, 12, 22), ("B", 20, 1, 7), ("C", 13, 8, 9))
group(name: "c", anchor: "south-west", {
anchor("default", "b.south-east")
chart.columnchart(size: (4, 3), mode: "stacked", value-key: (1,2,3), data)
})


#table(
  columns: (auto, auto, auto, auto),
  align: (center + horizon, center, center, center),
)
*/



#import "@preview/cetz:0.2.0"

#let margin = 0.5in
#set page(margin: 0.5in, paper: "us-letter")

#{
  cetz.canvas({
    import cetz.draw: *
    import cetz.chart
    line((0,0), (0,3), name: "a")
line((0,0), (2,0), name: "b")
// Draw an angle between the two lines
cetz.angle.right-angle("a.start", "a.end", "b.end", radius: 1)
let data = (("A", 10), ("B", 200), ("C", 13))
  let style = (
axes: (
tick: (length: 3),
grid: (stroke: (dash: "dotted")),
),
bar-width: 2,
x-inset: 1,
)
  set-style(..style)
chart.columnchart(
    ticks: 100, ,
    bar-width: 20,,
    size: (3, 6), ,
    data, 
    bar-style: cetz.palette.gray(70), )
  })
}

#{
  let gs = square(20pt, fill: red)
  place(dx: 0pt, dy: 0pt, gs)
}
