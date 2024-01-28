// https://typst.app/project/pfWcjFhGMJUyVTvJ8daQrR,


#import "@preview/cetz:0.2.0"

#let typst-rotate = rotate
// we rotate the vertical legend so that it is not sideways
// rename the rotate function because it exists in cetz

#let graph(o) = {
    // we can import cetz inside of function scopes
    cetz.canvas({
      import cetz.draw: *
      import cetz.chart

    let data = (("A", 10), ("B", 20), ("C", 13))
    group(name: "a", {
    chart.columnchart(
      y-tick-step: 4,
      // x-ticks: (1,2,3),
      // this messes up the centering
      size: (4, 3), o.data,
      // still not sure what this does

      y-label: y-label(o.labels.x),
      x-label: x-label(o.labels.y),
      outer-label-radius: 200%,
      // dont know what this does
      inner-label-radius: 200%,
      // dont know what this does
      x-inset: 2.5,
      labels: o.labels.labels
      // the spacing is kind of messed up for these items
    )
    })
  })
}

#{
  let a = graph(1)
  rect(inset: 20pt, 
  // two graphs stacked 
}

// util
#let flex(..args) = {
    let base-attrs = (
      dir: "ltr",
      spacing: 20pt,
    )
    let named-attrs = args.named()
    let attrs = util.merge(base-attrs, named-attrs)
    let value = stack(..attrs, ..items))
    // if attrs.border ... i mean just compose it
    // too many conditionals hard to remember
}

#let to-content(x) = {
    if is-string(x) {
        return text(x)
    }
    if is-content(x) {
        return x
    }
    // parse object to content

    let base = text(..x.style, x.text)
    return base
}
// util for 
#let y-label(x) = {
    h(-10pt)
    return rotate(90deg, to-content(x))
}

#let x-label(x) = {
    v(-10pt)
    return to-content(x)
}
