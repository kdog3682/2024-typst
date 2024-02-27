#import "very-base-utils.typ": *
#import "strokes.typ"


#let base = (
    value-key: "value",
    label-key: "label",
    outset-key: "outset",
    radius: 2,
    slice-style: alternating-white,
    inner-radius: 0,
    outer-label: (
        content: (value, label) => {
            return bold(label)
        },
        radius: 125%,
    ),
    inner-label: (
        content: (value, label) => {
            return resolve-content(value)
        },
        radius: 110%,
    ),
)


#let canola = (
    stroke: strokes.at("thin", fill: blue),
    radius: 2,
    inner-radius: 0,
    gap: 0,
    inner-label: (content: (value, label) => {
      align(center, block({
          text(weight: "bold", size: 10pt, label)
          text(weight: "bold", size: 10pt, value)
      }))
    } , radius: 120%)
)

#let soft = (
    stroke: strokes.get("soft"),
    inner-label: (
        content: (value, label) => {
            return text(red, [*#label*: #value])
        },
        radius: 110%,
    ),
)

