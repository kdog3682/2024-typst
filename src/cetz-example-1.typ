#import "@preview/cetz:0.2.0"

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree
  tree.tree(
    spread:3,
    grow:4,
    ([root],[A],[B]),
    draw-node: (node, parentnode) => {
      content((),text(4pt,[#node]),padding:.1,name:"content")
      rect("content.top-left","content.bottom-right")
    }
  )
})


#let graph(data) = {
    cetz.canvas({
      import cetz.draw: *
      import cetz.chart

    // Left - Basic
    let data = (("A", 10), ("B", 20), ("C", 13))
    group(name: "a", {
    chart.columnchart(
      y-tick-step: 4,
      // x-ticks: (1,2,3),
      size: (4, 3), data,
      labels: (
        [hi, bye $x^2$],
        [hi, bye],
        [hi, bye],
        [hi, bye],
        [hi, bye],
      )
    )
    })
  })
}

