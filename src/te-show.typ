show "hi": "ahs"
show "hxi": "aa"

// show rules are cumulative
// and they follow order

show block: (val) => {
  if type(val) == "content" {
    if (repr(val).text() == "aaaa") {
        val = "xxxxx"
    }
      // interesting ... this works
  }
  text(fill: red, val)



// this is a good example
#import "@preview/cetz:0.2.0"

#let typst-rotate = rotate
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
      
      y-label: {
        v(-10pt)
        typst-rotate(90deg, [hi])
      },
      x-label: {
        }
        block([hxiha])
        
        v(10pt)
        [*hi*]
      },
      outer-label-radius: 200%,
      inner-label-radius: 200%,
      x-inset: 2.5,
      labels: (
        [hi, bye $x^2$ \ ],
        [hi, bye],
        [hi, bye],
      )
    )
    })
  })
}

#{
  let a = graph(1)
  rect(inset: 20pt, stack(dir: ltr, spacing: 20pt, a, a))
}
