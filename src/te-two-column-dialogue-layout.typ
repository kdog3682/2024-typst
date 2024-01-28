#let dialogue-layouter(items) = {
  let store = ()
  for index, item in items.enumerate() {
    store.push(bold(index + 1))
    store.push(item)
  }

  let attrs = (columns: (auto, 1fr), column-gutter: 10pt, row-gutter: 10pt)
  grid(..attrs, ..store)
}
