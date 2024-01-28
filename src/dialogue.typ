#import "@preview/tablex:0.0.7": gridx, vlinex

#let bold-name(name) = {
    align(left)[*#name*]
}
#let dialogue-item(name, content) = {
  let grid = gridx(
    inset: 10pt,
    columns: (80pt, 1fr),
    bold-name(name), vlinex(stroke: black + 0.1pt), content
  )
  [#grid]
  v(20pt)
}

#let dialogue-runner-deprecated(items) = locate(loc => {
  for item in items {
  [#loc.position()]
    if loc.position().y > 100pt {
      pagebreak()      
    }
    dialoguer(item, content)    
  }
})

#let dialogue-runner(items) = {
  for item in abc {
      dialogue-item(..item)
  }
}
#let str-split(s, r) = {
   return s.split(regex(r)).filter(x => x.len() > 0)
}


