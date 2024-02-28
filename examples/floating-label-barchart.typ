#import "@preview/cetz:0.2.0"
#cetz.canvas({
  import cetz.draw: *

  let data = (
    (0, 60),
    (1, 10),
    (2,-20),
    (3,  2),
    (4,  5),
  )
  let month = (
    "Jan", "Feb", "Mar", "Apr", "May"
  )
  // this works
  set-style(
    axes: (
      grid: (
      stroke: blue
    ),
      minor-grid: (
      stroke: 0.5pt + red
    ),
  )
    
  )
    // this doesnt actually do anything
    set-style(
    mark: (fill: black, scale: 2),
    stroke: (thickness: 0.4pt, cap: "round"),
  )
  // set-style(axes: (stroke: none, tick: (stroke: none)))
  cetz.plot.plot(size: (6,6), axis-style: "scientific",
    y-min: -50,
    y-max: 75,
    y-grid: true,
    x-grid: "minor",
    y-format: v => [#v%],
    grid: (
      stroke: blue),
    x-min: -1,
    x-max: 6,
    y-tick-step: 15,
    y-minor-tick-step: 5,
    x-tick-step: 1,
    x-minor-tick-step: 0.25,
  {
    cetz.plot.add-bar(data, bar-width: .7, style: i => (
      stroke: blue,
      fill: if data.at(i).at(1) >= 0 { green } else { red } 
    ))
    cetz.plot.annotate({
      for (x, y) in data {
        let k = 1
        let anchor = if y >= 0 {
          "south"
        } else {
          k = -1
          "north"
        }
        content((x, y + k * 2), [*#month.at(x)*], anchor: anchor, padding: .1)
      }
    })
  })
})
