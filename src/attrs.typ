#import "very-base-utils.typ": *
#import "strokes.typ"


#let known = (
    fill: color,
    color: color,
    paint: color,
    stroke: stroke,
    width: length,
    length: length,
    thickness: length,
    size: length,
    height: length,
    align: alignment,
)


#let fills = (
    black: black,
    gray: gray,
    silver: silver,
    white: white,
    navy: navy,
    blue: blue,
    aqua: aqua,
    teal: teal,
    eastern: eastern,
    purple: purple,
    fuchsia: fuchsia,
    maroon: maroon,
    red: red,
    orange: orange,
    yellow: yellow,
    olive: olive,
    green: green,
    lime: lime,
)

#let alignments = (
    center: center,
    left: left,
    right: right,
    horizon: horizon,
)

#let units = (
    "pt": 1pt,
    "cm": 1cm,
    "in": 1in,
    "em": 1em,
    "%": 1%,
)


#let transformer(v, k) = {
    if k not in known {
        return v
    }

    let ref-type = known.at(k)

    if ref-type == color {
        return fills.at(v)
    }
    else if ref-type == alignment {
        return alignments.at(v)
    }
    else if ref-type == stroke {
        unreachable()
    }
    else if ref-type == alignment {
        return alignments.at(v)
    }
    else if ref-type == length {
        if is-number(v) {
            return v * 1pt
        } else {
            let m = match(v, "(.*?)(pt|%|cm|in|em)")
            if m != none {
                return float(m.first()) * units.at(m.last())
            }
        }
    }
}

#let transform(kwargs) = {
    return walk(kwargs, transformer)
}

#let sample = (
    color: (
        fill: "green",
        align: "center",
        color: "green",
    )
)

// #panic(transform(sample))
// each of the items is appropriately transformed into the typst version
// transform() takes regular json input and converts to typst types

#let fulfill(key) = {
    let schema = (
        canvas: (
            canvas-attrs:(
                 length: "1cm"
            ),
        )
    )
}

#let get(key) = {
    let ref = (
        double-sided-arrow-mark: (
            width: 0.2,
            length: 0.3,
            stroke: strokes.soft,
            start: ">",
            end: ">",
            fill: black,
        ),
        arrow-mark: (
            width: 3,
            length: 3,
            end: ">",
            fill: black,
        ),
        inline-canvas: (
            // stroke: black,
            // inset: 3pt,
            radius: 0pt,
            fill: none,
            outset: 0pt,
            baseline: baseline,
        ),
    )
    return ref.at(key)
}

