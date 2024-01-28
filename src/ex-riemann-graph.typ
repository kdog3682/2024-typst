// how do length and size work for these plots?


#set page(margin: 0.5pt)
#import "@preview/cetz:0.2.0"

#let exists(params) = {
  return true
}


// utility helper
#let get-anchor(a, b, ..args) = {
    let key = str(a) + "." + str(b)
    let args.named().at("delimiter", default: "")
    let positional = args.pos()
    if positional.len() > 0 {
        return positional.map((x) => key + delimiter + x)
    }
    return key
}


#let plotter(plot, body) = {
  plot.plot(name: "plot", size: (6, 6),
    // x-grid: true,
    // y-grid: true,
    // grid: true, // doesnt work

    axis-style: "school-book",
    x-tick-step: 2,
    x-minor-tick-step: 1,
    y-tick-step: auto, {
        body
    })
}

#let grapher(domain, fn, length: 0.5in, riemann: (beneath: true, rect-style: (fill: yellow.lighten(80%)))) = cetz.canvas(length: length, {
      import cetz.plot
      import cetz.draw: *

      plotter(plot, {
          plot.add(domain: domain, fn)

          // these anchors normalize the rectangle to the graph
          // this normaliztion is more effective
          if exists(riemann) {
              for i in range(..domain) {
                let value = if i > 0 {
                    fn(i)
                } else if i < 0 {
                    fn(i + 1)
                } else {
                  0
                }
                plot.add-anchor(str(i) + "a", (i, value))
                plot.add-anchor(str(i) + "b", (i + 1, 0))
              }
          }
      })

      if exists(riemann) {
          for i in range(..domain) {
              let (a, b) = get-anchor("plot", i, "a", "b")
              rect(a, b, ..riemann.rect-style)
          }
      }
})

#grapher((-5, 5), x => -calc.pow(x, 3))
