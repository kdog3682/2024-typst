#import "@preview/cetz:0.2.0"
#import cetz.draw: line, content

#let canvas = cetz.canvas
#let hpos(x1, x2, y: 0) = {
    return ((x1, y), (x2, y))
}

#let vpos(y1, y2, x: 0) = {
    return ((x, y1), (x, y2))
}

#let offset(point, x: 0, y: 0) = {
    x1 = point.at(0) + x
    y1 = point.at(1) + y
    return (x1, y1)
}

#let vline(a, b, x: 0, ..sink) = {
    let points = vpos(a, b, x: x)
    return line(..points, ..sink.named())
}

#let hline(a, b, y: 0, ..sink) = {
    let points = hpos(a, b, y: y)
    return line(..points, ..sink.named())
}


#let inline-canvas(fn, length: 1in) = {
    import "@preview/cetz:0.2.0"
    let c = cetz.canvas(length: length, fn(cetz.draw))
    return box(attrs.get("inline-canvas"), c)
}

