#let rosy(it) = locate((loc) => {
    if it.level == 1 {
        if loc.page > 1 {
            pagebreak()
            it
        } else {
            it
            v(12pt)
        }
    }
    else if it.level == 2 {
        it
        v(12pt)
    }
    else if it.level == 3 {
        it
        v(10pt)
    }
    else if it.level == 4 {
        it
        v(10pt)
    }
})


// this is used somewhere else
#let example = locate(loc => {
  let elems = query(
    selector(heading).before(loc),
    loc,
  )
  let academy = smallcaps[
    Typst Academy
  ]
  if elems == () {
    align(right, academy)
  } else {
    let body = elems.last().body
    academy + h(1fr) + emph(body)
  }
})
