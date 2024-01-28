#import "@preview/cetz:0.2.0"
#set page(width: auto, height: auto, margin: .5cm)

#let data = (
  ([Belgium],     24),
  ([Germany],     31),
  ([Turkey],      13),
)

#cetz.canvas({
  import cetz.chart
  import cetz.draw: *

  let colors = (gray.lighten(80%), gray.lighten(50%), gray.lighten(20%))

  // cant get the stroke to work.
  
  chart.piechart(
    style: (stroke: blue),
    data,
    value-key: 1,
    label-key: 0,
    radius: 2,
    slice-style: colors,
    inner-radius: 0,
    outset: 5,
    gap: 0.01,
    inner-label: (content: (value, label) => [
      //#text(white, str(value))
      #text(weight: "bold", size: 10pt, black, label)
    
    ], radius: 120%),
    outer-label: (content: "%", radius: 130%))

})
