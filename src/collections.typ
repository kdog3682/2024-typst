#let base-math-collect(regex: "aaaa", create: none, collect: none) = {
  locate((loc) => {
    let mathEquations = query(selector(math.equation).before(loc), loc)
    let collection = mathEquations.filter(collect)
    let tableItems = collection.enumerate().map(((i, x) => create(x, i))
    let table-attrs = (
        align: auto,
        column-gutter: auto,
        row-gutter: auto,
        columns: 2,
        fill: auto,
        // stroke: (
            // top: none,
            // left: none,
            // right: none,
            // bottom: none,
        // ),
        rows: auto,
    )

    return table(..table-attrs, ..tableItems.flatten())
  })
}


#let collect(eq) = {
    let kids = eq.body.children
    let first = kids.first()
    let fields = first.fields()
    let hasExponent = fields.at("t", default: none) != none
    let length = kids.len()
    return length > 6 and hasExponent
}
#let create(eq, i) = {
  let first = eq.body.children.first().fields()
  let statement = [The base for each part is $#first.base$.]
  let index = [*Example #{i + 1}*]
  return (index, eq, statement)
}
#let collect-exponents = base-math-collect.with(
    create: create,
    collect: collect,
)
