#import "@preview/cetz:0.2.0": draw, chart
#import "@preview/cetz:0.2.0"

// attributables
// exposes a get:function on the module
#import "attrs.typ"
#import "strokes.typ"
#import "piecharts.typ"
#import "barcharts.typ"

#let canvas-functions = (
    line: draw.line,
    circle: draw.circle,
    rect: draw.rect,
    group: draw.group,
    grid: draw.grid,
    set-style: draw.set-style,
    piechart: chart.piechart.with(..piecharts.base)
)

let sample-json = (
    attrs: (
        length: 1cm,
    ),
    children: (
        (
            handler: "line",
            args: ((0, 0), (5, 5)),
            kwargs:(
                
            )
        )
    )
)

#let data = (
  ( value: 17, label: "a", outset: true, ),
  ( value: 18, label: "b", outset: true, ),
  ( value: 30, label: "c", outset: false, ),
)
// get the color from the data perhaps.

#let canvas-renderer(json) = {
    json = attrs.transform(json)
    cetz.canvas(..json.canvas-attrs, {
        for child in json.children {
            let handler = child.at("handler")
            let kwargs = child.at("kwargs", default: (:))
            let args = child.at("args", default: ())
            let fn = canvas-functions.at(handler)
            fn(..args, ..kwargs)
        }
    })
}

