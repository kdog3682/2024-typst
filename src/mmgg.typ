#import "/home/kdog3682/2024/base-utils.typ": bold

#let mmgg-layouter(items) = {
  let store = ()
  for (index, item) in items.enumerate() {
    store.push(bold(index + 1))
    store.push(item)
  }

  let attrs = (columns: (auto, 1fr), column-gutter: 10pt, row-gutter: 24pt)
  return grid(..attrs, ..store)
}

#let mmgg-v1(data) = {
  set page(margin: 0.5in, paper: "us-letter", columns: 2, numbering: "1")
  set par(leading: 1.5em)
  
  [
    = #data.title
    #line(length: 100%)
  ]
  data.body
}


// this time the lines will be numbered
#let mmgg-v2(data) = {
  set page(margin: 0.5in, paper: "us-letter", columns: 2, numbering: "1")
  set par(leading: 1.2em)
  
  [
    = #data.title
    #line(length: 100%)
  ]
  mmgg-layouter(data.body)
}

#let mmgg = mmgg-v1
#let mmgg = mmgg-v2
#mmgg(json("/home/kdog3682/2024/temp.json"))
