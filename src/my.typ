#import "base-utils.typ": *
#import "attrs.typ"
#import "cetz-setup.typ": *

#let blue = colored.with(fill: _blue)
#let red = colored.with(fill: _red)
#let green = colored.with(fill: _green)
#let frac(a, b) = $display(_frac(#resolve-content(a), #resolve-content(b)))$

#let equal = wrap([=], h(4pt))
#let dot = wrap(sym.circle.filled.tiny, h(3pt))
#let plus = wrap(sym.plus, h(3pt))
#let times = wrap(sym.times, h(3pt))

#let arrow = {
    h(6pt)
    canvas(inline: true, {
        line((0, 0), (15, 0), mark: attrs.get("arrow-mark"))
    })
    h(7pt)
}

