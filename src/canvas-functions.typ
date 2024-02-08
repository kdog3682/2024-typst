#set page(width: auto, height: auto, margin: .5cm)

#import "@preview/cetz:0.2.0": draw, chart
#import "@preview/cetz:0.2.0"
#let canvas-functions = (
  line: draw.line,
  circle: draw.circle,
  rect: draw.rect,
  group: draw.group,
  grid: draw.grid,
  piechart: chart.piechart,
  bluechart: chart.piechart.with(inner-label: (content: (value, label) => [#text(blue, str(value))], radius: 110%)),
  // the label is right on the middle
)


#let data = (
  ([Belgium],     24),
  ([Germany],     31),
  ([Greece],      18),
  ([Spain],       21),
  ([France],      23),
  ([Hungary],     18),
  ([Netherlands], 27),
  ([Romania],     17),
  ([Finland],     26),
  ([Turkey],      13),
)

#cetz.canvas({
  // this stuff does something
  let colors = gradient.linear(red, blue, green, yellow)
  canvas-functions.at("bluechart")(
    data,
    value-key: 1,
    label-key: 0,
    radius: 4,
    slice-style: colors,
    inner-radius: 1,
    outset: 3,
    outer-label: (content: "%", radius: 110%))
})
