#import "base-utils.typ": *
#import "cetz-setup.typ": *

#let numberline(n, items) = {
  hline(0, n, mark: attrs.get("double-sided-arrow-mark"))

  let h = 0.25
  for i in range(1, n) {
      vline(-h, h, x: i)
  }
  for item in items {
      let p = (item.pos, 0.5)
      content(p, resolve-content(item.label))
  }
  // draw some braces connecting various items
  // make it stroked or dotted
  // working
}

#{
    let items = (
        (label: "A", pos: 3),
        (
            label: "B", 
            pos: 4, 
            linkage: (
                target: "A", 
                arrow: "to"
            ),
        ),
    )

    canvas({
        numberline(5, items)
    })
}
