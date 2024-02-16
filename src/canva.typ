#import "@preview/cetz:0.2.0"
#import "base-utils.typ": *


#set page(width: 8.5in, height: 11in, margin: 0pt)
#let create-page(dimensions, margin) = {

    // not doing anything with margins yet
    let o = (0, 0)

    let (ox, oy) = o
    // let ne = dimensions.map(resolve-inches)
    let ne = dimensions
    let (width, height) = ne
    let center = ne.map((x) => x / 2)
    let (half-width, half-height) = center
    let se = (width, oy)
    let nw = (ox, height)
    let positive-diagonal = (o, ne)
    let negative-diagonal = (nw, se)
    let dimensions = (o, ne)
    let center = (half-width, half-height)
    let west = (ox, half-height)
    let east = (width, half-height)
    let south = (half-width, oy)
    let north = (half-width, height)

    return (
        positive-diagonal: positive-diagonal,
        negative-diagonal: negative-diagonal,
        dimensions: dimensions,
        center: center,
        west: west,
        east: east,
        south: south,
        north: north,
    )
}


#let canva(fn, ..sink) = {
    let kwargs = sink.named()
    let box-attrs = (
        // stroke: black,
        stroke: none,
        inset: 0pt,
        radius: 0pt,
        fill: none,
        outset: 0pt,
    )

    let kwargs = sink.named()
    let dimensions = kwargs.at("dimensions", default: (8.5in, 11in))
    let margin = kwargs.at("margin", default: 0.5)
    // let k = 4
    // let k = 1
    // dimensions = dimensions.map((x) => x * k)
    // margin *= k
    // let margin = resolve-inches(margin)

    let length = 1in
    let page = create-page(dimensions, margin)
    // panic(page, length)
    let canvas-default-attrs = (
        length: length,
        // debug: true,
    )
    let canvas-attrs = assign-fresh(kwargs, canvas-default-attrs)
    let c = cetz.canvas(..canvas-attrs, fn(cetz.draw, page))
    return box(..box-attrs, c)
}

#let test-create(draw, page) = {
    draw.set-style(
        rect: (
            fill: red,
            stroke: none
        ),
        line: (
            fill: blue,
            stroke: (dash: "dashed")
        ),
        grid: (
            stroke: 0.5pt
        )
    )
    // draw.circle(page.center)
    // panic(page.dimensions)
    // draw.grid(..page.dimensions)
    // draw.grid((-1, 1), (8.5, 11))
    // draw.rect((0, 0), (1, 1))
    // return

    for (k, v) in page {
        if is-nested-array(v) {
            draw.line(..v)
        } else {
            draw.circle(v)
        }
    }
}

// the canvas is not directly aligned ... it is okay
// can do this later
#canva(test-create)


// useful helper information is contained in page
// page.origin
// page.center
// page.north
// these are coordinate points perhaps
#let draw-lines(draw, page) = {
    draw.line(..page.positive-diagonal)
    draw.line(..page.negative-diagonal)
    draw.grid(..page.dimensions)
}


#import "canva.typ": canva

#let cetz-background(create) = {
    return canva(create, length: 1in, background: blue.lighten(75%))
}



