// 
#import "@preview/cetz:0.2.0"

#let default-style = (
  tick-limit: 10,
  minor-tick-limit: 5,
  auto-tick-factors: ( 4, 5, 6, 8, 10), // Tick factor to try
  auto-tick-count: 10, // Number of ticks the plot tries to place
  fill: none,
  stroke: black + 0.75pt, // the container bars
  label: (
    offset: .2cm,       // Axis label offset
    anchor: auto,       // Axis label anchor
  ),
  tick: (
    fill: none,
    length: .1cm,       // Tick length: Number
    minor-length: 80%,  // Minor tick length: Number, Ratio
    minor-offset: 2,  // Minor tick length: Number, Ratio
    minor-stroke: 0.5pt,
    label: (
      offset: .2cm,     // Tick label offset
      angle: 0deg,      // Tick label angle
      anchor: auto,     // Tick label anchor
    )
  ),
  grid: (
    stroke: (paint: gray.lighten(50%), thickness: 0.8pt),
  ),
  minor-grid: (
    stroke: (paint: gray.lighten(50%), thickness: .8pt),
  ),
)

#let margin = 0.5in
#set page(margin: 0.5in, paper: "us-letter")

#let default-bar-style(idx) = {
  if calc.even(idx) {
    return (
      fill: blue
    )
  } else {
    (fill: green)
  }
}
#{
  cetz.canvas({
    import cetz.draw: *
    import cetz.chart
    set-style(
      axes: default-style
    )
    
  chart.columnchart(
    value-key: ("value", "value2"),
    label-key: "label",
    mode: "clustered",
    bar-width: 0.5,
    x-unit: "pt",
    y-unit: "pt",
    x-label: [*hi*],
    bar-style: default-bar-style,
    size: (auto, 6),
    //size: (5,5),
    ((
      label: "A",
      value: 12,
      value2: 16,
    ),
    (
      label: "A",
      value: 12,
      value2: 12,
    ))
  )
})
}
