#import "base-utils.typ": *

#let generate-points(domain, fn, skip: none) = {
    let skip-fn(x, y) = {
        if skip == none {
            return false
        }
        if is-array(skip) and x in skip {
            return true
        }
        if is-string(skip) {
            if skip == "odd" {
                return is-odd(x) 
            }
            else if skip == "even" {
                return is-even(x)
            }
            else {
                panic("aa")
            }
        }
        return skip(x, y)
    }
    let store = ()
    for i in range(domain.at(0), domain.at(1) + 1) {
        let pt = (i, fn(i))
        if not skip-fn(..pt) {
            store.push(pt)
        }
    }
    return store
}
#let skip = "odd"
#panic(generate-points((-3, 3), (x) => calc.pow(x, 2), skip: skip))


// v represents the value
// use with y-format: y-formatterr
// currently not used
#let y-formatter(v) = {
  if v == 0 {
    [#str(v)]
  } else {
    [#str(v)]
  }
}

#let pi-formatter(v) = if v != 0 {$ #{v/calc.pi} pi $} else {$ 0 $}
// formats the x-axis with pi

#let fn-xsquared = (x) => calc.pow(x, 2)
#let fn-xcubed = (x) => calc.pow(x, 3)


#let plot(domain) = {

  cetz.canvas({
    import cetz.plot
    import cetz.draw: *
  plot.plot(name: "p",
    //x-format: formatter,
    // x label is the "x"
    grid: "major",
    // didnt really do anything
    size: (4,4), 
    axis-style: "school-book", 
    // looks  quite nice
    x-minor-tick-step: 1,
    x-tick-step: 1, y-tick-step: y-tick-step, y-minor-tick-step: y-minor-tick-step, {
plot.add(domain: (0, 2*calc.pi), fn-xsquared)
    for i in range(2, 6) {
      plot.add-anchor(str(i), (i, fn-xsquared(i)))
      // drawing the rectangles can be done in a different way too
    }
    
    })
    for-each-anchor("p", (x) => {
      if x.match(regex("^\\d$")) != none {
      circle("p." + x, radius: 2pt, fill: black)
      }
    })

    for i in range(2, 7) {
      rect((i, 0), (i + 1, 2))
    }

    })
}









// i forgot what was supposed to happen ...
#import "@preview/cetz:0.2.0"

#let y-formatter(v) = {
  if v == 0 {
    [#str(v)]
  } else {
    [#str(v)]
  }
}
#let formatter(v) = if v != 0 {$ #{v/calc.pi} pi $} else {$ 0 $}
#let plot(content) = {
  cetz.canvas({
    import cetz.plot
    import cetz.draw: *
  plot.plot(name: "p",
    //x-format: formatter,
    // x label is the "x"
    grid: "major",
    y-minor-tick-step: 4,
    size: (4,4),
    axis-style: "school-book",
    x-minor-tick-step: 1,
    x-tick-step: 2, y-tick-step: 8, y-minor-tickstep: 4, {
    let fn = (x) => calc.pow(x, 2)
plot.add(domain: (-5, 5), fn)
    for i in range(2, 6) {
      plot.add-anchor(str(i), (i, fn(i)))
    }

})
for-each-anchor("p", (x) => {
  if x.match(regex("^\\d$")) != none {
  circle("p." + x, radius: 2pt, fill: black)
  }
})


})
}

#plot(1)
/*
#let grapher() = {
  cetz.canvas({
    import cetz.plot
    import cetz.draw: *
    plot.plot(size: (4, 4), name: "plot",
    data: (x) => calc.pow(x, 2),
    x-tick-step: 1, y-tick-step: 1,
    axis-style: "school-book", {
    plot.add(((0,0), (1,1), (2,1), (4,3)))
    plot.add-anchor("pt", (1,1))
    })

    //circle("plot.pt", radius: 0.5, fill: yellow)
    line("plot.pt", ((), "|-", (0, 2)), mark: (fill: black, start: "stealth", ), name: "line")
    content("line.end", [$(1,1)$], anchor: "south", padding: .2)
  })
}

*/
