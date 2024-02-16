#import "base-utils.typ": *
#import "styles.typ"

#let line(stroke: "hard", margin: none, length: 100%) = {
    let line-attrs = (
        stroke: resolve-dict(styles.strokes, stroke),
        length: length,
    )

    if margin != none {
        v(margin)
    }

    typst-line(..line-attrs)

    if margin != none {
        v(margin)
    }
}
