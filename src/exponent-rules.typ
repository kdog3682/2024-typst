#import "@preview/showybox:2.0.1": *
#import "base-utils.typ": *


#let render-exponent-json(ruleIds, singleton: false) = {
    let ruleIds = coerce-array(ruleIds)
    let data = json("/home/kdog3682/2024-typst/src/exponents.json")

    let line-attrs = (
      length: 100%,
      stroke: (thickness: 0.5pt, dash: "dotted"),
    )

    let render(exp) = {
        let rule = [*Rule #exp.id #h(10pt) #exp.rule*]
        let formula = mathup(exp.formula, size: none, label: "formula")
        let example = mathup(exp.example, size: none, label: "example")
        let eli5 = text(exp.eli5)
        let lineContent = line(..line-attrs)
        let hideIt = exp.id not in ruleIds
        if hideIt {
            return []
            let rule = [*Rule #exp.id*]
            return block({
                rule
                v(2pt)
                lineContent
            })
        }

        let content = block({
            centered(rule)
            v(2pt)
            lineContent
            v(2pt)
            pad(left: 10pt, {
                eli5
                v(5pt)
                formula
                v(2pt)
                example
            })
        })
        return content
    }

    if singleton == true {
        return render(data.first())
        
    }
    let table-attrs = (
        align: auto,
        column-gutter: 30pt,
        row-gutter: 10pt,
        columns: (1fr, 1fr),
        // stroke: (
            // top: none,
            // left: none,
            // right: none,
            // bottom: none,
        // ),
        stroke: none,
        rows: auto,
    )
    return table(..table-attrs, ..data.map(render))
}


#let exponent-rules(n, singleton: true) = {
    
    let width = 100%
    if singleton == true {
        width = 50%
    }

    let color = blue
    let content = render-exponent-json(n, singleton: singleton)
    showybox(
      title: "Exponent Rules",
      width: width,
      title-style: (
        weight: 900,
        sep-thickness: 1pt,
        align: left,
      ),
      // body-style: (
          // inset: 40pt
      // ),
      frame: (
        border-color: color,
        title-color: color.lighten(30%),
        body-inset: 15pt,
        body-color: color.lighten(98%),
        // footer-color: color.lighten(80%)
      ),
      content
    )
}
